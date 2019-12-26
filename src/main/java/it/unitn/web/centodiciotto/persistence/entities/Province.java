package it.unitn.web.centodiciotto.persistence.entities;

/**
 * Province entity for modelling real-world administrative divisions.
 */
public class Province {
    private String ID;
    private String name;
    private String region;

    /**
     * Gets the ID of the Province, represented as a captial two-letter abbreviation (AA to ZZ).
     *
     * @return the ID
     */
    public String getID() {
        return ID;
    }

    /**
     * Sets the abbreviation of the Province. The abbreviation MUST be a capital two-letter abbreviation (AA to ZZ).
     *
     * @param ID the ID
     */
    public void setID(String ID) {
        this.ID = ID;
    }

    /**
     * Gets the name.
     *
     * @return the name
     */
    public String getName() {
        return name;
    }

    /**
     * Sets the name.
     *
     * @param name the name
     */
    public void setName(String name) {
        this.name = name;
    }

    /**
     * Gets the region.
     *
     * @return the region
     */
    public String getRegion() {
        return region;
    }

    /**
     * Sets the region.
     *
     * @param region the region
     */
    public void setRegion(String region) {
        this.region = region;
    }

    @Override
    public String toString() {
        return name + " (" + ID + ")";
    }
}
