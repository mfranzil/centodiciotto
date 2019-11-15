package it.unitn.web.centodiciotto.persistence.entities;

/**
 * User entity.
 * <p>
 * This entity exists only to be subclassed by other classes, specializing it into a proper account type.
 * <p>
 * This entity implements hash and salt fields instead of the classic password field, to be used in conjunction
 * with a proper hash+salt method.
 */
public class User {
    /**
     * The userID, represented by his/her e-mail in a {@link String} form.
     */
    protected String ID;
    private String hash;
    private String salt;

    /**
     * Gets the salt.
     *
     * @return the salt
     */
    public String getSalt() {
        return salt;
    }

    /**
     * Sets the salt.
     *
     * @param salt the salt
     */
    public void setSalt(String salt) {
        this.salt = salt;
    }

    /**
     * Gets the ID.
     *
     * @return the ID
     */
    public String getID() {
        return ID;
    }

    /**
     * Sets the ID.
     *
     * @param ID the ID
     */
    public void setID(String ID) {
        this.ID = ID;
    }

    /**
     * Gets the hash.
     *
     * @return the hash
     */
    public String getHash() {
        return hash;
    }

    /**
     * Sets the hash.
     *
     * @param hash the hash
     */
    public void setHash(String hash) {
        this.hash = hash;
    }
}