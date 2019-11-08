package it.unitn.web.centodiciotto.persistence.entities;

public class DoctorExam {
    private String doctorID;
    private Integer examListID;

    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public Integer getExamListID() {
        return examListID;
    }

    public void setExamListID(Integer examListID) {
        this.examListID = examListID;
    }
}
