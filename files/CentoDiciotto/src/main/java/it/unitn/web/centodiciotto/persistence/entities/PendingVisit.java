package it.unitn.web.centodiciotto.persistence.entities;

public class PendingVisit {
    private Integer pendingVisitID;
    private String patientEmail;
    private String practitionerEmail;

    public PendingVisit(Integer pendingVisitID, String patientEmail, String practitionerEmail) {
        this.pendingVisitID = pendingVisitID;
        this.patientEmail = patientEmail;
        this.practitionerEmail = practitionerEmail;
    }

    public Integer getPendingVisitID() {
        return pendingVisitID;
    }

    public void setPendingVisitID(Integer pendingVisitID) {
        this.pendingVisitID = pendingVisitID;
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
}
