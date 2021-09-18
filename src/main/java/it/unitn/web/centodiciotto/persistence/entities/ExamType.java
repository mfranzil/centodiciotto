package it.unitn.web.centodiciotto.persistence.entities;

/**
 * ExamType entity for giving names to the types of {@link Exam}s that can be done.
 */
public class ExamType {
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
