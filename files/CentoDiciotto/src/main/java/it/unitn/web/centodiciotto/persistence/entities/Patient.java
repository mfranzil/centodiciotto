package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Patient {
    private String email;
    private String firstName;
    private String lastName;
    private Date birthDate;
    private String birthPlace;
    private String ssn;
    private Character gender;
    private String livingProvince;
    private String generalPractitionerEmail;
    private Integer photoId;

    public Patient(String email, String firstName, String lastName, Date birthDate, String birthPlace, String ssn,
                   Character gender, String livingProvince, String generalPractitionerEmail, Integer photoId) {
        this.email = email;
        this.firstName = firstName;
        this.lastName = lastName;
        this.birthDate = birthDate;
        this.birthPlace = birthPlace;
        this.ssn = ssn;
        this.gender = gender;
        this.livingProvince = livingProvince;
        this.generalPractitionerEmail = generalPractitionerEmail;
        this.photoId = photoId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getBirthPlace() {
        return birthPlace;
    }

    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    public String getSsn() {
        return ssn;
    }

    public void setSsn(String ssn) {
        this.ssn = ssn;
    }

    public Character getGender() {
        return gender;
    }

    public void setGender(Character gender) {
        this.gender = gender;
    }

    public String getLivingProvince() {
        return livingProvince;
    }

    public void setLivingProvince(String livingProvince) {
        this.livingProvince = livingProvince;
    }

    public String getGeneralPractitionerEmail() {
        return generalPractitionerEmail;
    }

    public void setGeneralPractitionerEmail(String generalPractitionerEmail) {
        this.generalPractitionerEmail = generalPractitionerEmail;
    }

    public Integer getPhotoId() {
        return photoId;
    }

    public void setPhotoId(Integer photoId) {
        this.photoId = photoId;
    }
}