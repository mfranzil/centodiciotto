package it.unitn.web.centodiciotto.persistence.entities;

/**
 * DrugType entity for assigning names to {@link DrugPrescription} medicines.
 */
public class DrugType {
    private Integer ID;
    private String description;

    /**
     * Gets the ID.
     *
     * @return the ID
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets the ID.
     *
     * @param ID the ID
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * Gets the description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
