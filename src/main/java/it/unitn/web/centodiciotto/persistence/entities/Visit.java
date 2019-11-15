package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Visit.
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
     * @return the boolean
     */
    public boolean isBooked() {
        return booked;
    }

    /**
     * Sets booked.
     *
     * @param booked the booked
     */
    public void setBooked(boolean booked) {
        this.booked = booked;
    }

    /**
     * Gets id.
     *
     * @return the id
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets id.
     *
     * @param visitID the visit id
     */
    public void setID(Integer visitID) {
        this.ID = visitID;
    }

    /**
     * Gets patient id.
     *
     * @return the patient id
     */
    public String getPatientID() {
        return patientID;
    }

    /**
     * Sets patient id.
     *
     * @param patientID the patient id
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets practitioner id.
     *
     * @return the practitioner id
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets practitioner id.
     *
     * @param practitionerID the practitioner id
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    /**
     * Gets date.
     *
     * @return the date
     */
    public Timestamp getDate() {
        return date;
    }

    /**
     * Sets date.
     *
     * @param date the date
     */
    public void setDate(Timestamp date) {
        this.date = date;
    }

    /**
     * Gets report available.
     *
     * @return the report available
     */
    public Boolean getReportAvailable() {
        return reportAvailable;
    }

    /**
     * Sets report available.
     *
     * @param reportAvailable the report available
     */
    public void setReportAvailable(Boolean reportAvailable) {
        this.reportAvailable = reportAvailable;
    }

    /**
     * Gets report.
     *
     * @return the report
     */
    public String getReport() {
        return report;
    }

    /**
     * Sets report.
     *
     * @param report the report
     */
    public void setReport(String report) {
        this.report = report;
    }
}
