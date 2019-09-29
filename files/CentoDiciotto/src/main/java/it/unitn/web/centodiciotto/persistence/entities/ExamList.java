package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class ExamList {
    private Integer ExamID;
    private String ExamDescription;

    public Integer getExamID() {
        return ExamID;
    }

    public void setExamID(Integer examID) {
        ExamID = examID;
    }

    public String getExamDescription() {
        return ExamDescription;
    }

    public void setExamDescription(String examDescription) {
        ExamDescription = examDescription;
    }

    public ExamList(Integer ExamID, String ExamDescription) {
        this.ExamID = ExamID;
        this.ExamDescription = ExamDescription;
    }

}
