package it.unitn.web.centodiciotto.persistence.entities;

public class User {
    private String email;
    private String password;


    public User(String email, String password){
        this.email = email;
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // TODO
    // TODO
    // DA MODIFICARE: E' UN PLACEHOLDER
    // TODO
    // TODO

    public String getRole() {
        return "citizen";
    }
    public String getFirstName() {
        return "citizen";
    }
    public String getLastName() {
        return "citizen";
    }
}