package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Patient extends User {
    private String firstName;
    private String lastName;
    private Timestamp birthDate;
    private String birthPlace;
    private String SSN;
    private Character gender;
    private Province livingProvince;
    private String livingPlace;
    private String practitionerID;

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

    public Timestamp getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Timestamp birthDate) {
        this.birthDate = birthDate;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    public String getSSN() {
        return SSN;
    }

    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    public Character getGender() {
        return gender;
    }

    public void setGender(Character gender) {
        this.gender = gender;
    }

    public Province getLivingProvince() {
        return livingProvince;
    }

    public void setLivingProvince(Province livingProvince) {
        this.livingProvince = livingProvince;
    }

    public String getLivingPlace() {
        return livingPlace;
    }

    public void setLivingPlace(String livingPlace) {
        this.livingPlace = livingPlace;
    }

    public String getPractitionerID() {
        return practitionerID;
    }

    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}