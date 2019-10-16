package it.unitn.web.centodiciotto.persistence.entities;

public class PendingVisit {
    private String patientID;
    private String practitionerID;

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
}
