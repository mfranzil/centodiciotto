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
     * Gets exam type.
     *
     * @return the exam type
     */
    public ExamType getExamType() {
        return examType;
    }

    /**
     * Sets exam type.
     *
     * @param examType the exam type
     */
    public void setExamType(ExamType examType) {
        this.examType = examType;
    }

    /**
     * Gets min age.
     *
     * @return the min age
     */
    public Integer getMinAge() {
        return minAge;
    }

    /**
     * Sets min age.
     *
     * @param minAge the min age
     */
    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    /**
     * Gets max age.
     *
     * @return the max age
     */
    public Integer getMaxAge() {
        return maxAge;
    }

    /**
     * Sets max age.
     *
     * @param maxAge the max age
     */
    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    /**
     * Gets start date.
     *
     * @return the start date
     */
    public Timestamp getStartDate() {
        return startDate;
    }

    /**
     * Sets start date.
     *
     * @param startDate the start date
     */
    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    /**
     * Gets health service id.
     *
     * @return the health service id
     */
    public String getHealthServiceID() {
        return healthServiceID;
    }

    /**
     * Sets health service id.
     *
     * @param healthServiceID the health service id
     */
    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
    }
}
