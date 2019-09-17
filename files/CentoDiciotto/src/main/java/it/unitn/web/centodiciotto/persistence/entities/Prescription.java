package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Date;

public class Prescription {
    private Integer prescriptionID;
    private String prescriptionPractitioner;
    private String prescriptionPatient;
    private Date prescriptionDate;
    private String drugDescription;


    public Prescription(Integer prescriptionID, String prescriptionPractitioner, String prescriptionPatient, Date prescriptionDate, String drugDescription){
        this.prescriptionID = prescriptionID;
        this.prescriptionPractitioner = prescriptionPractitioner;
        this.prescriptionPatient = prescriptionPatient;
        this.prescriptionDate = prescriptionDate;
        this.drugDescription = drugDescription;
    }

    public int getPrescriptionID(){ return this.prescriptionID; }

    public void setPrescriptionID(Integer prescriptionID){ this.prescriptionID = prescriptionID; }

    public String getPrescriptionPractitioner(){ return this.prescriptionPractitioner; }

    public void setPrescriptionPractitioner(String prescriptionPractitioner){ this.prescriptionPractitioner = prescriptionPractitioner; }

    public String getPrescriptionPatient(){ return this.prescriptionPatient; }

    public void setPrescriptionPatient(String prescriptionPatient){ this.prescriptionPatient = prescriptionPatient; }

    public Date getPrescriptionDate(){ return this.prescriptionDate; }

    public void setPrescriptionDate(Date prescriptionDate){  this.prescriptionDate = prescriptionDate; }

    public String getDrugDescription(){ return this.drugDescription; }

    public void setDrugDescription(String drugDescription){ this.drugDescription = drugDescription; }

}
