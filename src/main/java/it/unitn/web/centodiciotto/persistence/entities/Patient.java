package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Patient.
 */
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

    /**
     * Gets first name.
     *
     * @return the first name
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets first name.
     *
     * @param firstName the first name
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets last name.
     *
     * @return the last name
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets last name.
     *
     * @param lastName the last name
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets birth date.
     *
     * @return the birth date
     */
    public Timestamp getBirthDate() {
        return birthDate;
    }

    /**
     * Sets birth date.
     *
     * @param birthDate the birth date
     */
    public void setBirthDate(Timestamp birthDate) {
        this.birthDate = birthDate;
    }

    /**
     * Gets birth place.
     *
     * @return the birth place
     */
    public String getBirthPlace() {
        return birthPlace;
    }

    /**
     * Sets birth place.
     *
     * @param birthPlace the birth place
     */
    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    /**
     * Gets ssn.
     *
     * @return the ssn
     */
    public String getSSN() {
        return SSN;
    }

    /**
     * Sets ssn.
     *
     * @param SSN the ssn
     */
    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    /**
     * Gets gender.
     *
     * @return the gender
     */
    public Character getGender() {
        return gender;
    }

    /**
     * Sets gender.
     *
     * @param gender the gender
     */
    public void setGender(Character gender) {
        this.gender = gender;
    }

    /**
     * Gets living province.
     *
     * @return the living province
     */
    public Province getLivingProvince() {
        return livingProvince;
    }

    /**
     * Sets living province.
     *
     * @param livingProvince the living province
     */
    public void setLivingProvince(Province livingProvince) {
        this.livingProvince = livingProvince;
    }

    /**
     * Gets living place.
     *
     * @return the living place
     */
    public String getLivingPlace() {
        return livingPlace;
    }

    /**
     * Sets living place.
     *
     * @param livingPlace the living place
     */
    public void setLivingPlace(String livingPlace) {
        this.livingPlace = livingPlace;
    }

    /**
     * Gets practitioner id.
     *
     * @return the practitioner id
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets practitioner id.
     *
     * @param practitionerID the practitioner id
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}