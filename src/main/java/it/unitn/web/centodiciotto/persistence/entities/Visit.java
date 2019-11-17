package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * Visit entity that represents a potential Visit made by a {@link Patient} at a {@link GeneralPractitioner}.
 */
public class Visit {
    private Integer ID;
    private String patientID;
    private String practitionerID;
    private Timestamp date;
    private Boolean reportAvailable;
    private String report;
    private boolean booked;

    /**
     * Is booked boolean.
     *
     * @return true if the visit is booked
     */
    public boolean getBooked() {
        return booked;
    }

    /**
     * Sets the booked flag
     *
     * @param booked true if the visit is booked
     */
    public void setBooked(boolean booked) {
        this.booked = booked;
    }

    /**
     * Gets the ID.
     *
     * @return the ID
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets the ID.
     *
     * @param visitID the visitID
     */
    public void setID(Integer visitID) {
        this.ID = visitID;
    }

    /**
     * Gets the patientID.
     *
     * @return the patientID
     */
    public String getPatientID() {
        return patientID;
    }

    /**
     * Sets the patientID.
     *
     * @param patientID the patientID
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets the practitionerID
     *
     * @return the practitionerID
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets the practitionerID
     *
     * @param practitionerID the practitionerID
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    /**
     * Gets the date.
     *
     * @return the date
     */
    public Timestamp getDate() {
        return date;
    }

    /**
     * Sets the date.
     *
     * @param date the date
     */
    public void setDate(Timestamp date) {
        this.date = date;
    }

    /**
     * Gets the report available.
     *
     * @return the report available
     */
    public Boolean getReportAvailable() {
        return reportAvailable;
    }

    /**
     * Sets the report available.
     *
     * @param reportAvailable the report available
     */
    public void setReportAvailable(Boolean reportAvailable) {
        this.reportAvailable = reportAvailable;
    }

    /**
     * Gets the report.
     *
     * @return the report
     */
    public String getReport() {
        return report;
    }

    /**
     * Sets the report.
     *
     * @param report the report
     */
    public void setReport(String report) {
        this.report = report;
    }
}
