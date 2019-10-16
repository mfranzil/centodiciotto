package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Exam {
    private Integer ExamID;
    private String patientEmail;
    private String doctorEmail;
    private Integer examType;
    private Boolean examDone;
    private Timestamp examDate;
    private String examResult;
    private Integer healthServiceId;
    private Integer ticket;
    private Integer examPrescriptionId;

    public Integer getExamID() {
        return ExamID;
    }

    public void setExamID(Integer examID) {
        ExamID = examID;
    }

    public String getPatientEmail() {
        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        patientEmail = patientEmail;
    }

    public String getDoctorEmail() {
        return doctorEmail;
    }

    public void setDoctorEmail(String doctorEmail) {
        this.doctorEmail = doctorEmail;
    }

    public Integer getExamType() {
        return examType;
    }

    public void setExamType(Integer examType) {
        this.examType = examType;
    }

    public Boolean getExamDone() {
        return examDone;
    }

    public void setExamDone(Boolean examDone) {
        this.examDone = examDone;
    }

    public Timestamp getExamDate() {
        return examDate;
    }

    public void setExamDate(Timestamp examDate) {
        this.examDate = examDate;
    }

    public String getExamResult() {
        return examResult;
    }

    public void setExamResult(String examResult) {
        this.examResult = examResult;
    }

    public Integer getHealthServiceId() {
        return healthServiceId;
    }

    public void setHealthServiceId(Integer healthServiceId) {
        this.healthServiceId = healthServiceId;
    }

    public Integer getTicket() {
        return ticket;
    }

    public void setTicket(Integer ticket) {
        this.ticket = ticket;
    }

    public Integer getExamPrescriptionId() {
        return examPrescriptionId;
    }

    public void setExamPrescriptionId(Integer examPrescriptionId) {
        this.examPrescriptionId = examPrescriptionId;
    }
}
