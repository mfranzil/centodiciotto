package it.unitn.web.centodiciotto.persistence.entities;

import java.security.SecureRandom;
import java.sql.Timestamp;
import java.util.Base64;

public class PasswordReset {
    private String email;
    private String token;
    private Timestamp expiringDate;

    public static String generateRandomBase64Token() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] token = new byte[32];
        secureRandom.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

    public PasswordReset(String email, String token, Timestamp expiringDate) {
        this.email = email;
        this.token = token;
        this.expiringDate = expiringDate;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getToken() {
        return token;
    }

    public void setToken(String token) {
        this.token = token;
    }

    public Timestamp getExpiringDate() {
        return expiringDate;
    }

    public void setExpiringDate(Timestamp expiringDate) {
        this.expiringDate = expiringDate;
    }
}
