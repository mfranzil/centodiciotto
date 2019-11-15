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
     * @param ID the ID
     */
    public void setID(int ID) {
        this.ID = ID;
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
     * Gets the upload date.
     *
     * @return the upload date
     */
    public Timestamp getUploadDate() {
        return uploadDate;
    }

    /**
     * Sets the upload date.
     *
     * @param uploadDate the upload date
     */
    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
}
