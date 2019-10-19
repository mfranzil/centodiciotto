package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Prescription {
    private Integer ID;
    private String practitionerID;
    private String patientID;
    private Date date;
    private String description;

    public int getID() {
        return this.ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getPractitionerID() {
        return this.practitionerID;
    }

    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    public String getPatientID() {
        return this.patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public Date getDate() {
        return this.date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
