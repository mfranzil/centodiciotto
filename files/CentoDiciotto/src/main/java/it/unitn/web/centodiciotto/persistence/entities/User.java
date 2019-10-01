package it.unitn.web.centodiciotto.persistence.entities;

public class User {
    protected String email;
    protected String hash;
    protected String salt;

    public User(String email){
        this.email = email;
        this.hash = "";
        this.salt = "";
    };

    public User(String email, String hash, String salt) {
        this.email = email;
        this.hash = hash;
        this.salt = salt;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }


}