package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Visit {
    private Integer visitID;
    private String patientEmail;
    private String practitionerEmail;
    private Timestamp visitDate;
    private Boolean reportAvailable;
    private String report;

    public Visit(Integer visitID, String practitionerEmail, String patientEmail, Timestamp visitDate, Boolean reportAvailable, String report) {
        this.visitID = visitID;
        this.patientEmail = patientEmail;
        this.practitionerEmail = practitionerEmail;
        this.visitDate = visitDate;
        this.reportAvailable = reportAvailable;
        this.report = report;
    }

    public Integer getVisitID() {
        return visitID;
    }

    public void setVisitID(Integer visitID) {
        this.visitID = visitID;
    }

    public String getPatientEmail() {
        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        this.patientEmail = patientEmail;
    }

    public String getPractitionerEmail() {
        return practitionerEmail;
    }

    public void setPractitionerEmail(String practitionerEmail) {
        this.practitionerEmail = practitionerEmail;
    }

    public Timestamp getVisitDate() {
        return visitDate;
    }

    public void setVisitDate(Timestamp visitDate) {
        this.visitDate = visitDate;
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
