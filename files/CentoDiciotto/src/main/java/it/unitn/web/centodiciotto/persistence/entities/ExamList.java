package it.unitn.web.centodiciotto.persistence.entities;

public class ExamList {
    private Integer examID;
    private String examDescription;

    public Integer getExamID() {
        return examID;
    }

    public void setExamID(Integer examID) {
        this.examID = examID;
    }

    public String getExamDescription() {
        return examDescription;
    }

    public void setExamDescription(String examDescription) {
        this.examDescription = examDescription;
    }
}
