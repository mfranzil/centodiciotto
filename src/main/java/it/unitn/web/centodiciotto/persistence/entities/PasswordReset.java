package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Password reset.
 */
public class PasswordReset {
    private String userID;
    private String token;
    private Timestamp expiringDate;

    /**
     * Gets user id.
     *
     * @return the user id
     */
    public String getUserID() {
        return userID;
    }

    /**
     * Sets user id.
     *
     * @param userID the user id
     */
    public void setUserID(String userID) {
        this.userID = userID;
    }

    /**
     * Gets token.
     *
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * Sets token.
     *
     * @param token the token
     */
    public void setToken(String token) {
        this.token = token;
    }

    /**
     * Gets expiring date.
     *
     * @return the expiring date
     */
    public Timestamp getExpiringDate() {
        return expiringDate;
    }

    /**
     * Sets expiring date.
     *
     * @param expiringDate the expiring date
     */
    public void setExpiringDate(Timestamp expiringDate) {
        this.expiringDate = expiringDate;
    }
}
