package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * {@link PasswordReset} entity for storing temporary information about {@link User}s who needed a password reset.
 */
public class PasswordReset {
    private String userID;
    private String token;
    private Timestamp expiringDate;

    /**
     * Gets the userID
     *
     * @return the userID
     */
    public String getUserID() {
        return userID;
    }

    /**
     * Sets the userID
     *
     * @param userID the userID
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * Gets the token.
     *
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * Sets the token.
     *
     * @param token the token
     */
    public void setToken(String token) {
        this.token = token;
    }

    /**
     * Gets the expiring date.
     *
     * @return the expiring date
     */
    public Timestamp getExpiringDate() {
        return expiringDate;
    }

    /**
     * Sets the expiring date.
     *
     * @param expiringDate the expiring date
     */
    public void setExpiringDate(Timestamp expiringDate) {
        this.expiringDate = expiringDate;
    }
}
