package it.unitn.web.centodiciotto.services;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOException;
import it.unitn.web.centodiciotto.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.centodiciotto.persistence.dao.factories.DAOFactory;
import it.unitn.web.centodiciotto.persistence.entities.User;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Random;

/**
 * CryptoService service class, used to expose methods that provide authentication and random string generation.
 * <p>
 * The service implements the Singleton pattern.
 * <p>
 * The service needs an initialized DAOFactory to instantiate one DAO for each user class,
 * and instantiates a SecureRandom instance on startup.
 */
public class CryptoService {
    private static CryptoService instance;

    private transient final int ITERATIONS = 10000;
    private transient final int KEY_LENGTH = 512;
    private transient final int SALT_LENGTH = 8;

    private final transient Random RANDOM;
    private final transient UserDAO userDAO;
    private final transient PatientDAO patientDAO;
    private final transient GeneralPractitionerDAO practitionerDAO;
    private final transient SpecializedDoctorDAO doctorDAO;
    private final transient ChemistDAO chemistDAO;
    private final transient HealthServiceDAO healthServiceDAO;

    private CryptoService(DAOFactory daoFactory) throws ServiceException {
        RANDOM = new SecureRandom();
        if (daoFactory == null) {
            throw new ServiceException("DAOFactory is null.");
        }
        try {
            userDAO = daoFactory.getDAO(UserDAO.class);

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            doctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServiceException("Error in DAO retrieval: ", e);
        }
    }

    /**
     * Configuration method for the service.
     *
     * @param daoFactory the DAOFactory
     * @throws ServiceException in case of error during processing
     */
    public static void configure(DAOFactory daoFactory) throws ServiceException {
        if (instance == null) {
            instance = new CryptoService(daoFactory);
        } else {
            throw new ServiceException("CryptoService already configured. You can call configure only one time");
        }
    }

    /**
     * Instance retriever for the service.
     *
     * @return the instance
     * @throws ServiceException in case of error during processing
     */
    public static CryptoService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("CryptoService not yet configured. " +
                    "Cal CryptoService.configure() before use the class");
        }
        return instance;
    }

    /**
     * Receives a password and a salt as parameter and outputs a KEY_LENGTH long hash using a
     * {@link SecretKeyFactory}, which is then converted to Hexadecimal.
     * <p>
     * The final length is KEY_LENGTH / 4 due to the hex conversion.
     *
     * @param password the password
     * @param salt     the salt
     * @return a hexadecimal hash of the two parameters
     * @throws ServiceException in case of error during processing
     */
    private String hash(String password, String salt) throws ServiceException {
        char[] passwordChar = password.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(passwordChar, salt.getBytes(), ITERATIONS, KEY_LENGTH);
        Arrays.fill(passwordChar, Character.MIN_VALUE);
        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            return bytesToHex(skf.generateSecret(spec).getEncoded());
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new ServiceException("Error while hashing a password: " + e.getMessage(), e);
        } finally {
            spec.clearPassword();
        }
    }

    /**
     * Barebones implementation for converting a byte array to a hexadecimal {@link String} representation.
     *
     * @param bytes an array of bytes to be converted to hex
     * @return a {@link String} of hexadecimal characters
     */
    private String bytesToHex(byte[] bytes) {
        final char[] HEX_ARRAY = "0123456789ABCDEF".toCharArray();
        char[] hexChars = new char[bytes.length * 2];
        for (int j = 0; j < bytes.length; j++) {
            int v = bytes[j] & 0xFF;
            hexChars[j * 2] = HEX_ARRAY[v >>> 4];
            hexChars[j * 2 + 1] = HEX_ARRAY[v & 0x0F];
        }
        return new String(hexChars);
    }

    /**
     * Checks if the hash provided matches the password using the salt.
     *
     * @param password     the password
     * @param salt         the salt
     * @param expectedHash the hash to be checked
     * @return true if the hash was obtained from the password hashed with the salt
     * @throws ServiceException in case of error during processing
     */
    private boolean isExpectedPassword(String password, String salt, String expectedHash) throws ServiceException {
        String inputHash = hash(password, salt);
        Arrays.fill(password.toCharArray(), Character.MIN_VALUE);
        if (inputHash.length() != expectedHash.length()) {
            return false;
        }
        for (int i = 0; i < inputHash.length(); i++) {
            if (inputHash.charAt(i) != expectedHash.charAt(i)) {
                return false;
            }
        }
        return true;
    }

    /**
     * Returns the next salt of length SALT_LENGTH * 2.
     *
     * @return a hexadecimal salt
     */
    private String getNextSalt() {
        byte[] salt = new byte[SALT_LENGTH];
        RANDOM.nextBytes(salt);
        return bytesToHex(salt);
    }

    /**
     * Gets the next base64 token, used for {@link it.unitn.web.centodiciotto.persistence.entities.PasswordReset} tokens.
     *
     * @return the next base64 token
     */
    public String getNextBase64Token() {
        byte[] token = new byte[32];
        RANDOM.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

    /**
     * Authenticates the user.
     * <p>
     * The role provided must be one of "patient", "general_practitioner", "specialized_doctor",
     * "chemist", or "health_service". Failure to do so will invalidate the authentication process even
     * if the ID and the password match.
     * <p>
     * After confirming the authentication, the method returns a User subclass of the proper role.
     * <p>
     * In case the authentication fails, it returns {@code null}.
     *
     * @param ID       the userID
     * @param password the password
     * @param role     the role
     * @return a {@link User} subclass of the same role, or {@code null}.
     * @throws ServiceException in case of error during processing
     */
    public User authenticate(String ID, String password, String role) throws ServiceException {
        if (ID == null || password == null || ID.equals("") || password.equals("")) {
            throw new ServiceException("Email or password are null.");
        }

        String[] roles = {"patient", "general_practitioner", "specialized_doctor", "chemist", "health_service"};

        boolean roleValid = Arrays.stream(roles).anyMatch(role::contains);

        if (!roleValid) {
            throw new ServiceException("Invalid role name.");
        }

        try {
            User user = userDAO.getByPrimaryKey(ID);

            if (user != null && isExpectedPassword(password, user.getSalt(), user.getHash())) {
                return switch (role) {
                    case "patient" -> patientDAO.getByPrimaryKey(ID);
                    case "general_practitioner" -> practitionerDAO.getByPrimaryKey(ID);
                    case "specialized_doctor" -> doctorDAO.getByPrimaryKey(ID);
                    case "chemist" -> chemistDAO.getByPrimaryKey(ID);
                    case "health_service" -> healthServiceDAO.getByPrimaryKey(ID);
                    default -> null;
                };
            } else {
                return null;
            }
        } catch (DAOException e) {
            throw new ServiceException("Error while authenticating: ", e);
        }
    }

    /**
     * Changes the password of a {@link User}
     *
     * @param ID          the ID
     * @param newPassword the new password
     * @throws ServiceException in case of error during processing
     */
    public void changePassword(String ID, String newPassword) throws ServiceException {
        if (ID == null || newPassword == null || ID.equals("") || newPassword.equals("")) {
            throw new ServiceException("Email or password are null.");
        }

        String newSalt = getNextSalt();
        String newHash = hash(newPassword, newSalt);

        User user = new User();
        user.setID(ID);
        user.setHash(newHash);
        user.setSalt(newSalt);

        try {
            userDAO.update(user);
        } catch (DAOException e) {
            throw new ServiceException("Error while changing password: ", e);
        }
    }

    /**
     * Controls if the password provided matches the one in the database.
     *
     * @param ID       the ID
     * @param password the password
     * @return true if the password is the one currently saved
     * @throws ServiceException in case of error during processing
     */
    public boolean isCurrentPassword(String ID, String password) throws ServiceException {
        if (ID == null || password == null || ID.equals("") || password.equals("")) {
            throw new ServiceException("Email or password (or both) are null.");
        }

        try {
            User user = userDAO.getByPrimaryKey(ID);
            return isExpectedPassword(password, user.getSalt(), user.getHash());
        } catch (DAOException e) {
            throw new ServiceException("Error while checking for password match: ", e);
        }
    }
}
