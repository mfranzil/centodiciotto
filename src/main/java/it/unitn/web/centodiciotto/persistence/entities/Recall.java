package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Recall {
    private Integer ID;
    private ExamList examType;
    private Integer minAge;
    private Integer maxAge;
    private Timestamp startDate;
    private String healthServiceID;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public ExamList getExamType() {
        return examType;
    }

    public void setExamType(ExamList examType) {
        this.examType = examType;
    }

    public Integer getMinAge() {
        return minAge;
    }

    public void setMinAge(Integer minAge) {
        this.minAge = minAge;
    }

    public Integer getMaxAge() {
        return maxAge;
    }

    public void setMaxAge(Integer maxAge) {
        this.maxAge = maxAge;
    }

    public Timestamp getStartDate() {
        return startDate;
    }

    public void setStartDate(Timestamp startDate) {
        this.startDate = startDate;
    }

    public String getHealthServiceID() {
        return healthServiceID;
    }

    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
    }
}
