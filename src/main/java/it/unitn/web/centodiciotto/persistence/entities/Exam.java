package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Exam {
    private Integer ID;
    private String patientID;
    private String doctorID;
    private ExamList type;
    private Boolean done;
    private Timestamp date;
    private String result;
    private Integer healthServiceID;
    private Integer ticket;
    private Integer examPrescriptionID;
    private boolean ticketPaid;
    private boolean recall;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public String getDoctorID() {
        return doctorID;
    }

    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    public ExamList getType() {
        return type;
    }

    public void setType(ExamList type) {
        this.type = type;
    }

    public Boolean getDone() {
        return done;
    }

    public void setDone(Boolean done) {
        this.done = done;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public Integer getHealthServiceID() {
        return healthServiceID;
    }

    public void setHealthServiceID(Integer healthServiceID) {
        this.healthServiceID = healthServiceID;
    }

    public Integer getTicket() {
        return ticket;
    }

    public void setTicket(Integer ticket) {
        this.ticket = ticket;
    }

    public Integer getExamPrescriptionID() {
        return examPrescriptionID;
    }

    public void setExamPrescriptionID(Integer examPrescriptionID) {
        this.examPrescriptionID = examPrescriptionID;
    }

    public boolean isTicketPaid() {
        return ticketPaid;
    }

    public void setTicketPaid(boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    public boolean isRecall() {
        return recall;
    }

    public void setRecall(boolean recall) {
        this.recall = recall;
    }
}
