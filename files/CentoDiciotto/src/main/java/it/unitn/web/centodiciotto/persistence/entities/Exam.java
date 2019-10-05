package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

public class Exam {
    private Integer ExamID;
    private String PatientEmail;
    private String DoctorEmail;
    private Integer ExamType;
    private Boolean ExamDone;
    private Timestamp ExamDate;
    private String ExamResult;
    private String ExamDescription;

    public Exam(Integer ExamID, String PatientEmail, String DoctorEmail, Integer ExamType, Boolean ExamDone, Timestamp ExamDate, String ExamResult) {
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

    public Timestamp getExamDate() {
        return ExamDate;
    }

    public void setExamDate(Timestamp examDate) {
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
