package it.unitn.web.centodiciotto.persistence.entities;

import java.security.SecureRandom;
import java.sql.Date;
import java.util.Base64;

public class PasswordReset {
    private String email;
    private String token;
    private Date expiringDate;

    public static String generateRandomBase64Token() {
        SecureRandom secureRandom = new SecureRandom();
        byte[] token = new byte[32];
        secureRandom.nextBytes(token);
        return Base64.getUrlEncoder().withoutPadding().encodeToString(token);
    }

    public PasswordReset(String email, String token, Date expiringDate) {
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

    public Date getExpiringDate() {
        return expiringDate;
    }

    public void setExpiringDate(Date expiringDate) {
        this.expiringDate = expiringDate;
    }
}
