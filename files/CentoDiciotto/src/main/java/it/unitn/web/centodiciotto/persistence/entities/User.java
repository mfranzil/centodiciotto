package it.unitn.web.centodiciotto.persistence.entities;

public class User {
    private Integer id;
    private String email;
    private String password;
    private String firstName;
    private String lastName;
    private Integer avatarPathId;

    public User(Integer id, String email, String password, String firstName, String lastName){
        this.id = id;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.avatarPathId = null;
    }

    public User(Integer id, String email, String password, String firstName, String lastName, Integer avatarPathId){
        this.id = id;
        this.email = email;
        this.password = password;
        this.firstName = firstName;
        this.lastName = lastName;
        this.avatarPathId = avatarPathId;
    }


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }


    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }


    public Integer getAvatarPathId() {
        return avatarPathId;
    }

    public void setAvatarPathId(Integer avatarPathId) {
        this.avatarPathId = avatarPathId;
    }

}