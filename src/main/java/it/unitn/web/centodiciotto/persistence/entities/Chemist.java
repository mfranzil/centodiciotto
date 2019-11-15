package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type Chemist.
 */
public class Chemist extends User {
    private String name;
    private Province province;
    private String workingPlace;

    /**
     * Gets name.
     *
     * @return the name
     */
    public String getName() {
        return this.name;
    }

    /**
     * Sets name.
     *
     * @param Name the name
     */
    public void setName(String Name) {
        this.name = Name;
    }

    /**
     * Gets province.
     *
     * @return the province
     */
    public Province getProvince() {
        return province;
    }

    /**
     * Sets province.
     *
     * @param province the province
     */
    public void setProvince(Province province) {
        this.province = province;
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
        return name;
    }
}

