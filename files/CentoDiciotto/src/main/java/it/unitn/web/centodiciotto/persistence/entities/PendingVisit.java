package it.unitn.web.centodiciotto.persistence.entities;

public class PendingVisit {
    private String patientEmail;
    private String practitionerEmail;

    public PendingVisit(String patientEmail, String practitionerEmail) {
        this.patientEmail = patientEmail;
        this.practitionerEmail = practitionerEmail;
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
