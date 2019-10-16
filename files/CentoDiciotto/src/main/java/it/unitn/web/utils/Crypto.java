package it.unitn.web.utils;

import it.unitn.web.centodiciotto.persistence.dao.*;
import it.unitn.web.centodiciotto.persistence.entities.User;
import it.unitn.web.persistence.dao.exceptions.DAOException;
import it.unitn.web.persistence.dao.exceptions.DAOFactoryException;
import it.unitn.web.persistence.dao.factories.DAOFactory;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.xml.bind.DatatypeConverter;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Arrays;
import java.util.Base64;
import java.util.Random;

public class Crypto {
    private static final int ITERATIONS = 10000;
    private static final int KEY_LENGTH = 512;
    private static Random RANDOM;

    private static UserDAO userDAO;

    private static PatientDAO patientDAO;
    private static GeneralPractitionerDAO practitionerDAO;
    private static SpecializedDoctorDAO specializedDoctorDAO;
    private static ChemistDAO chemistDAO;
    private static HealthServiceDAO healthServiceDAO;

    public static void configure(DAOFactory daoFactory) throws RuntimeException {
        RANDOM = new SecureRandom();
        if (daoFactory == null) {
            throw new RuntimeException("Impossible to get dao factory for user storage system");
        }
        try {
            userDAO = daoFactory.getDAO(UserDAO.class);

            patientDAO = daoFactory.getDAO(PatientDAO.class);
            practitionerDAO = daoFactory.getDAO(GeneralPractitionerDAO.class);
            specializedDoctorDAO = daoFactory.getDAO(SpecializedDoctorDAO.class);
            chemistDAO = daoFactory.getDAO(ChemistDAO.class);
            healthServiceDAO = daoFactory.getDAO(HealthServiceDAO.class);
        } catch (DAOFactoryException ex) {
            throw new RuntimeException("Impossible to get dao factory for user storage system", ex);
        }
    }

    private static String hash(String password, String salt) {
        char[] passwordChar = password.toCharArray();
        PBEKeySpec spec = new PBEKeySpec(passwordChar, salt.getBytes(), ITERATIONS, KEY_LENGTH);
        Arrays.fill(passwordChar, Character.MIN_VALUE);
        try {
            SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
            return DatatypeConverter.printHexBinary(skf.generateSecret(spec).getEncoded());
        } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
            throw new AssertionError("Error while hashing a password: " + e.getMessage(), e);
        } finally {
            spec.clearPassword();
        }
    }

    private static boolean isExpectedPassword(String password, String salt, String expectedHash) {
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

    private static String getNextSalt() {
        byte[] salt = new byte[8];
        RANDOM.nextBytes(salt);
        return DatatypeConverter.printHexBinary(salt);
    }

    public static String getNextBase64Token() {
        byte[] token = new byte[32];
        RANDOM.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

    public static User authenticate(String email, String password, String role) throws RuntimeException {
        if (email == null || password == null || email.equals("") || password.equals("")) {
            throw new RuntimeException("Email or password are null.");
        }

        String[] roles = {"patient", "general_practitioner", "specialized_doctor", "chemist", "health_service"};

        if (!Common.containsItemFromArray(role, roles)) {
            throw new RuntimeException("Invalid role name.");
        }

        try {
            User user = userDAO.getByPrimaryKey(email);

            if (user != null && isExpectedPassword(password, user.getSalt(), user.getHash())) {
                switch (role) {
                    case "patient":
                        return patientDAO.getByPrimaryKey(email);
                    case "general_practitioner":
                        return practitionerDAO.getByPrimaryKey(email);
                    case "specialized_doctor":
                        return specializedDoctorDAO.getByPrimaryKey(email);
                    case "chemist":
                        return chemistDAO.getByPrimaryKey(email);
                    case "health_service":
                        return healthServiceDAO.getByPrimaryKey(email);
                    default:
                        return null;
                }
            } else {
                return null;
            }
        } catch (DAOException e) {
            throw new RuntimeException("Error in authentication method." + e.getMessage());
        }
    }

    public static void changePassword(String email, String newPassword) throws RuntimeException {
        if (email == null || newPassword == null || email.equals("") || newPassword.equals("")) {
            throw new RuntimeException("Email or password are null.");
        }

        String newSalt = getNextSalt();
        String newHash = hash(newPassword, newSalt);

        User user = new User();
        user.setID(email);
        user.setHash(newHash);
        user.setSalt(newSalt);

        try {
            userDAO.update(user);
        } catch (DAOException e) {
            throw new RuntimeException("Error in Password " + e.getMessage());
        }
    }

    public static boolean isCurrentPassword(String email, String password) throws RuntimeException {
        if (email == null || password == null || email.equals("") || password.equals("")) {
            throw new RuntimeException("Email or password are null.");
        }

        try {
            User user = userDAO.getByPrimaryKey(email);
            return isExpectedPassword(password, user.getSalt(), user.getHash());
        } catch (DAOException e) {
            throw new RuntimeException("Error in authentication method." + e.getMessage());
        }
    }
}
