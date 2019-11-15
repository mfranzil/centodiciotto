package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * Patient entity. Represents the "patient" user class.
 * Subclasses {@link User} for authentication purposes.
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
     * Gets the first name.
     *
     * @return the first name
     */
    public String getFirstName() {
        return firstName;
    }

    /**
     * Sets the first name.
     *
     * @param firstName the first name
     */
    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    /**
     * Gets the last name.
     *
     * @return the last name
     */
    public String getLastName() {
        return lastName;
    }

    /**
     * Sets the last name.
     *
     * @param lastName the last name
     */
    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    /**
     * Gets the birth date.
     *
     * @return the birth date
     */
    public Timestamp getBirthDate() {
        return birthDate;
    }

    /**
     * Sets the birth date.
     *
     * @param birthDate the birth date
     */
    public void setBirthDate(Timestamp birthDate) {
        this.birthDate = birthDate;
    }

    /**
     * Gets the birth place.
     *
     * @return the birth place
     */
    public String getBirthPlace() {
        return birthPlace;
    }

    /**
     * Sets the birth place.
     *
     * @param birthPlace the birth place
     */
    public void setBirthPlace(String birthPlace) {
        this.birthPlace = birthPlace;
    }

    /**
     * Gets the ssn.
     *
     * @return the ssn
     */
    public String getSSN() {
        return SSN;
    }

    /**
     * Sets the ssn.
     *
     * @param SSN the ssn
     */
    public void setSSN(String SSN) {
        this.SSN = SSN;
    }

    /**
     * Gets the gender.
     *
     * @return the gender
     */
    public Character getGender() {
        return gender;
    }

    /**
     * Sets the gender.
     *
     * @param gender the gender
     */
    public void setGender(Character gender) {
        this.gender = gender;
    }

    /**
     * Gets the living province.
     *
     * @return the living province
     */
    public Province getLivingProvince() {
        return livingProvince;
    }

    /**
     * Sets the living province.
     *
     * @param livingProvince the living province
     */
    public void setLivingProvince(Province livingProvince) {
        this.livingProvince = livingProvince;
    }

    /**
     * Gets the living place.
     *
     * @return the living place
     */
    public String getLivingPlace() {
        return livingPlace;
    }

    /**
     * Sets the living place.
     *
     * @param livingPlace the living place
     */
    public void setLivingPlace(String livingPlace) {
        this.livingPlace = livingPlace;
    }

    /**
     * Gets the practitionerID
     *
     * @return the practitionerID
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets the practitionerID
     *
     * @param practitionerID the practitionerID
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}