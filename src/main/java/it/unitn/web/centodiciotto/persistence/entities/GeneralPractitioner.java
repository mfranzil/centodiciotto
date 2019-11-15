package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type General practitioner.
 */
public class GeneralPractitioner extends User {
    private String firstName;
    private String lastName;
    private Province workingProvince;
    private String workingPlace;

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
     * Gets working province.
     *
     * @return the working province
     */
    public Province getWorkingProvince() {
        return workingProvince;
    }

    /**
     * Sets working province.
     *
     * @param workingProvince the working province
     */
    public void setWorkingProvince(Province workingProvince) {
        this.workingProvince = workingProvince;
    }

    /**
     * Gets working place.
     *
     * @return the working place
     */
    public String getWorkingPlace() {
        return workingPlace;
    }

    /**
     * Sets working place.
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

