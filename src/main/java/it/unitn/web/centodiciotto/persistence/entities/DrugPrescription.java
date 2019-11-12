package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

public class DrugPrescription {
    private Integer ID;
    private String practitionerID;
    private String patientID;
    private DrugType drugType;
    private Timestamp datePrescribed;
    private Timestamp dateSold;
    private String chemistID;
    private Integer ticket;
    private Boolean ticketPaid;
    private String description;

    public Integer getID() {
        return ID;
    }

    public void setID(Integer ID) {
        this.ID = ID;
    }

    public String getPractitionerID() {
        return practitionerID;
    }

    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    public String getPatientID() {
        return patientID;
    }

    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    public DrugType getDrugType() {
        return drugType;
    }

    public void setDrugType(DrugType drugType) {
        this.drugType = drugType;
    }

    public Timestamp getDatePrescribed() {
        return datePrescribed;
    }

    public void setDatePrescribed(Timestamp datePrescribed) {
        this.datePrescribed = datePrescribed;
    }

    public Timestamp getDateSold() {
        return dateSold;
    }

    public void setDateSold(Timestamp dateSold) {
        this.dateSold = dateSold;
    }

    public String getChemistID() {
        return chemistID;
    }

    public void setChemistID(String chemistID) {
        this.chemistID = chemistID;
    }

    public Integer getTicket() {
        return ticket;
    }

    public void setTicket(Integer ticket) {
        this.ticket = ticket;
    }

    public Boolean getTicketPaid() {
        return ticketPaid;
    }

    public void setTicketPaid(Boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}
