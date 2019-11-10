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

public class CryptoService {
    private static CryptoService instance;

    private transient final int ITERATIONS = 10000;
    private transient final int KEY_LENGTH = 512;

    private transient Random RANDOM;
    private transient UserDAO userDAO;
    private transient PatientDAO patientDAO;
    private transient GeneralPractitionerDAO practitionerDAO;
    private transient SpecializedDoctorDAO specializedDoctorDAO;
    private transient ChemistDAO chemistDAO;
    private transient HealthServiceDAO healthServiceDAO;

    private CryptoService(DAOFactory daoFactory) throws ServiceException {
        RANDOM = new SecureRandom();
        if (daoFactory == null) {
            throw new ServiceException("DAOFactory is null.");
        }
        try {
            userDAO = daoFactory.getDAO(UserDAO.class);

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
        } catch (DAOFactoryException e) {
            throw new ServiceException("Error in DAO retrieval: ", e);
        }
    }

    public static void configure(DAOFactory daoFactory) throws ServiceException {
        if (instance == null) {
            instance = new CryptoService(daoFactory);
        } else {
            throw new ServiceException("EmailService already configured. You can call configure only one time");
        }
    }

    public static CryptoService getInstance() throws ServiceException {
        if (instance == null) {
            throw new ServiceException("EmailService not yet configured. " +
                    "Call EmaiLService.configure() before use the class");
        }
        return instance;
    }

    private String hash(String password, String salt) {
        char[] passwordChar = password.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(passwordChar, salt.getBytes(), ITERATIONS, KEY_LENGTH);
        Arrays.fill(passwordChar, Character.MIN_VALUE);
        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            return bytesToHex(skf.generateSecret(spec).getEncoded());
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new AssertionError("Error while hashing a password: " + e.getMessage(), e);
        } finally {
            spec.clearPassword();
        }
    }

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

    private boolean isExpectedPassword(String password, String salt, String expectedHash) {
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

    private String getNextSalt() {
        byte[] salt = new byte[8];
        RANDOM.nextBytes(salt);
        return bytesToHex(salt);
    }

    public String getNextBase64Token() {
        byte[] token = new byte[32];
        RANDOM.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

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
                switch (role) {
                    case "patient":
                        return patientDAO.getByPrimaryKey(ID);
                    case "general_practitioner":
                        return practitionerDAO.getByPrimaryKey(ID);
                    case "specialized_doctor":
                        return specializedDoctorDAO.getByPrimaryKey(ID);
                    case "chemist":
                        return chemistDAO.getByPrimaryKey(ID);
                    case "health_service":
                        return healthServiceDAO.getByPrimaryKey(ID);
                    default:
                        return null;
                }
            } else {
                return null;
            }
        } catch (DAOException e) {
            throw new ServiceException("Error while authenticating: ", e);
        }
    }

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
