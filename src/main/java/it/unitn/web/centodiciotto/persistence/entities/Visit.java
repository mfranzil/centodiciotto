package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Visit {
    private Integer ID;
    private String patientID;
    private String practitionerID;
    private Timestamp date;
    private Boolean reportAvailable;
    private String report;
    private boolean booked;

    public boolean isBooked() {
        return booked;
    }

    public void setBooked(boolean booked) {
        this.booked = booked;
    }

    public Integer getID() {
        return ID;
    }

    public void setID(Integer visitID) {
        this.ID = visitID;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public String getPractitionerID() {
        return practitionerID;
    }

    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    public Timestamp getDate() {
        return date;
    }

    public void setDate(Timestamp date) {
        this.date = date;
    }

    public Boolean getReportAvailable() {
        return reportAvailable;
    }

    public void setReportAvailable(Boolean reportAvailable) {
        this.reportAvailable = reportAvailable;
    }

    public String getReport() {
        return report;
    }

    public void setReport(String report) {
        this.report = report;
    }
}
