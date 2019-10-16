package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Prescription {
    private Integer ID;
    private String practitionerID;
    private String patientID;
    private Date date;
    private String drugDescription;

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

    public String getDrugDescription() {
        return this.drugDescription;
    }

    public void setDrugDescription(String drugDescription) {
        this.drugDescription = drugDescription;
    }
}
