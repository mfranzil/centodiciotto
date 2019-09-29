package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Exam {
    private Integer ExamID;
    private String PatientEmail;
    private String DoctorEmail;
    private Integer ExamType;
    private Boolean ExamDone;
    private Date ExamDate;
    private String ExamResult;
    private String ExamDescription;

    public Exam(Integer ExamID, String PatientEmail, String DoctorEmail, Integer ExamType, Boolean ExamDone, Date ExamDate, String ExamResult) {
        this.ExamID = ExamID;
        this.PatientEmail = PatientEmail;
        this.DoctorEmail = DoctorEmail;
        this.ExamType = ExamType;
        this.ExamDone = ExamDone;
        this.ExamDate = ExamDate;
        this.ExamResult = ExamResult;
    }

    public Integer getExamID() {
        return ExamID;
    }

    public void setExamID(Integer examID) {
        ExamID = examID;
    }

    public String getPatientEmail() {
        return PatientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        PatientEmail = patientEmail;
    }

    public String getDoctorEmail() {
        return DoctorEmail;
    }

    public void setDoctorEmail(String doctorEmail) {
        DoctorEmail = doctorEmail;
    }

    public Integer getExamType() {
        return ExamType;
    }

    public void setExamType(Integer examType) {
        ExamType = examType;
    }

    public Boolean getExamDone() {
        return ExamDone;
    }

    public void setExamDone(Boolean examDone) {
        ExamDone = examDone;
    }

    public Date getExamDate() {
        return ExamDate;
    }

    public void setExamDate(Date examDate) {
        ExamDate = examDate;
    }

    public String getExamResult() {
        return ExamResult;
    }

    public void setExamResult(String examResult) {
        ExamResult = examResult;
    }

    public String getExamDescription() {
        return ExamDescription;
    }

    public void setExamDescription(String examDescription) {
        ExamDescription = examDescription;
    }


}
