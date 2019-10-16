package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class Photo {
    private Integer ID;
    private String patientID;
    private Timestamp uploadDate;

    public Integer getID() {
        return ID;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public Timestamp getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Timestamp uploadDate) {
        this.uploadDate = uploadDate;
    }
}
