package it.unitn.web.centodiciotto.persistence.entities;

/**
 * GeneralPractitioner entity. Represents the "general_practitioner" user class.
 * Subclasses {@link User} for authentication purposes.
 */
public class GeneralPractitioner extends User {
    private String firstName;
    private String lastName;
    private Province workingProvince;
    private String workingPlace;

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
     * Gets the working province.
     *
     * @return the working province
     */
    public Province getWorkingProvince() {
        return workingProvince;
    }

    /**
     * Sets the working province.
     *
     * @param workingProvince the working province
     */
    public void setWorkingProvince(Province workingProvince) {
        this.workingProvince = workingProvince;
    }

    /**
     * Gets the working place.
     *
     * @return the working place
     */
    public String getWorkingPlace() {
        return workingPlace;
    }

    /**
     * Sets the working place.
     *
     * @param workingPlace the working place
     */
    public void setWorkingPlace(String workingPlace) {
        this.workingPlace = workingPlace;
    }

    @Override
    public String toString() {
        return firstName + " " + lastName;
    }
}

