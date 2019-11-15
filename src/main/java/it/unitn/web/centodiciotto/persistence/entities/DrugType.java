package it.unitn.web.centodiciotto.persistence.entities;

/**
 * The type Drug type.
 */
public class DrugType {
    private Integer ID;
    private String description;

    /**
     * Gets id.
     *
     * @return the id
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets id.
     *
     * @param ID the id
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * Gets description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets description.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
