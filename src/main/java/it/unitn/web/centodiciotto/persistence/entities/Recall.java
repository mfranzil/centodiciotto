package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Recall.
 */
public class Recall {
    private Integer ID;
    private ExamType examType;
    private Integer minAge;
    private Integer maxAge;
    private Timestamp startDate;
    private String healthServiceID;

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
     * Gets the exam type.
     *
     * @return the exam type
     */
    public ExamType getExamType() {
        return examType;
    }

    /**
     * Sets the exam type.
     *
     * @param examType the exam type
     */
    public void setExamType(ExamType examType) {
        this.examType = examType;
    }

    /**
     * Gets the min age.
     *
     * @return the min age
     */
    public Integer getMinAge() {
        return minAge;
    }

    /**
     * Sets the min age.
     *
     * @param minAge the min age
     */
    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    /**
     * Gets the max age.
     *
     * @return the max age
     */
    public Integer getMaxAge() {
        return maxAge;
    }

    /**
     * Sets the max age.
     *
     * @param maxAge the max age
     */
    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    /**
     * Gets the start date.
     *
     * @return the start date
     */
    public Timestamp getStartDate() {
        return startDate;
    }

    /**
     * Sets the start date.
     *
     * @param startDate the start date
     */
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    /**
     * Gets the health serviceID.
     *
     * @return the health serviceID
     */
    public String getHealthServiceID() {
        return healthServiceID;
    }

    /**
     * Sets the health serviceID.
     *
     * @param healthServiceID the health serviceID
     */
    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
    }
}
