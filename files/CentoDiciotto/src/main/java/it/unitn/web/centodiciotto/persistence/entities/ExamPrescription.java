package it.unitn.web.centodiciotto.persistence.entities;

public class ExamPrescription {
    public Integer getPrescriptionID() {
        return PrescriptionID;
    }

    public void setPrescriptionID(Integer prescriptionID) {
        PrescriptionID = prescriptionID;
    }

    public String getPatientEmail() {
        return PatientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        PatientEmail = patientEmail;
    }

    public String getPractitionerEmail() {
        return PractitionerEmail;
    }

    public void setPractitionerEmail(String practitionerEmail) {
        PractitionerEmail = practitionerEmail;
    }

    public Boolean getExamBooked() {
        return ExamBooked;
    }

    public void setExamBooked(Boolean examBooked) {
        ExamBooked = examBooked;
    }

    public Integer getExamType() {
        return ExamType;
    }

    public void setExamType(Integer examType) {
        ExamType = examType;
    }

    private Integer PrescriptionID;
    private String PatientEmail;
    private String PractitionerEmail;
    private Boolean ExamBooked;
    private Integer ExamType;

    public ExamPrescription(Integer PrescriptionID, String PatientEmail, String PractitionerEmail, Integer ExamType, Boolean examBooked) {
        this.PrescriptionID = PrescriptionID;
        this.PatientEmail = PatientEmail;
        this.PractitionerEmail = PractitionerEmail;
        this.ExamBooked = examBooked;
        this.ExamType = ExamType;
    }

}
