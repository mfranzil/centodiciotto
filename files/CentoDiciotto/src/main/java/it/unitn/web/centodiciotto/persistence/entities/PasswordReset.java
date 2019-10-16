package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class PasswordReset {
    private String email;
    private String token;
    private Timestamp expiringDate;

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
