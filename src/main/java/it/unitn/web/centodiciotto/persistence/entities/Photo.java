package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Photo.
 */
public class Photo {
    private Integer ID;
    private String patientID;
    private Timestamp uploadDate;

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
     * @param ID the id
     */
    public void setID(int ID) {
        this.ID = ID;
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
     * Gets upload date.
     *
     * @return the upload date
     */
    public Timestamp getUploadDate() {
        return uploadDate;
    }

    /**
     * Sets upload date.
     *
     * @param uploadDate the upload date
     */
    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
}
