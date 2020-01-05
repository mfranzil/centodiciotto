package it.unitn.web.centodiciotto.persistence.entities;

/**
 * Province entity for modelling real-world administrative divisions.
 */
public class Province {
    private String ID;
    private String name;
    private String region;

    /**
     * Gets the ID of the Province, represented as two capital letters (AA to ZZ).
     *
     * @return the ID
     */
    public String getID() {
        return ID;
    }

    /**
     * Sets the ID of the Province. The ID MUST be composed of two capital letters (AA to ZZ).
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
