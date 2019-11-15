package it.unitn.web.centodiciotto.persistence.entities;

/**
 * Chemist entity. Represents the "chemist" user class.
 * Subclasses {@link User} for authentication purposes.
 */
public class Chemist extends User {
    private String name;
    private Province province;
    private String workingPlace;

    /**
     * Gets the name.
     *
     * @return the name
     */
    public String getName() {
        return this.name;
    }

    /**
     * Sets the name.
     *
     * @param Name the name
     */
    public void setName(String Name) {
        this.name = Name;
    }

    /**
     * Gets the province.
     *
     * @return the province
     */
    public Province getProvince() {
        return province;
    }

    /**
     * Sets the province.
     *
     * @param province the province
     */
    public void setProvince(Province province) {
        this.province = province;
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
        return name;
    }
}

