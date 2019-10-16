package it.unitn.web.centodiciotto.persistence.entities;

public class ExamPrescription {
    private Integer prescriptionID;
    private String patientEmail;
    private String practitionerEmail;
    private Boolean examBooked;
    private Integer examType;

    public Integer getPrescriptionID() {
        return prescriptionID;
    }

    public void setPrescriptionID(Integer prescriptionID) {
        this.prescriptionID = prescriptionID;
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

    public Boolean getExamBooked() {
        return examBooked;
    }

    public void setExamBooked(Boolean examBooked) {
        this.examBooked = examBooked;
    }

    public Integer getExamType() {
        return examType;
    }

    public void setExamType(Integer examType) {
        this.examType = examType;
    }
}
