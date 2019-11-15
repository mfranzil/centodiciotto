package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Drug prescription.
 */
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

    /**
     * Gets id.
     *
     * @return the id
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets id.
     *
     * @param ID the id
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * Gets practitioner id.
     *
     * @return the practitioner id
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets practitioner id.
     *
     * @param practitionerID the practitioner id
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    /**
     * Gets patient id.
     *
     * @return the patient id
     */
    public String getPatientID() {
        return patientID;
    }

    /**
     * Sets patient id.
     *
     * @param patientID the patient id
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets drug type.
     *
     * @return the drug type
     */
    public DrugType getDrugType() {
        return drugType;
    }

    /**
     * Sets drug type.
     *
     * @param drugType the drug type
     */
    public void setDrugType(DrugType drugType) {
        this.drugType = drugType;
    }

    /**
     * Gets date prescribed.
     *
     * @return the date prescribed
     */
    public Timestamp getDatePrescribed() {
        return datePrescribed;
    }

    /**
     * Sets date prescribed.
     *
     * @param datePrescribed the date prescribed
     */
    public void setDatePrescribed(Timestamp datePrescribed) {
        this.datePrescribed = datePrescribed;
    }

    /**
     * Gets date sold.
     *
     * @return the date sold
     */
    public Timestamp getDateSold() {
        return dateSold;
    }

    /**
     * Sets date sold.
     *
     * @param dateSold the date sold
     */
    public void setDateSold(Timestamp dateSold) {
        this.dateSold = dateSold;
    }

    /**
     * Gets chemist id.
     *
     * @return the chemist id
     */
    public String getChemistID() {
        return chemistID;
    }

    /**
     * Sets chemist id.
     *
     * @param chemistID the chemist id
     */
    public void setChemistID(String chemistID) {
        this.chemistID = chemistID;
    }

    /**
     * Gets ticket.
     *
     * @return the ticket
     */
    public Integer getTicket() {
        return ticket;
    }

    /**
     * Sets ticket.
     *
     * @param ticket the ticket
     */
    public void setTicket(Integer ticket) {
        this.ticket = ticket;
    }

    /**
     * Gets ticket paid.
     *
     * @return the ticket paid
     */
    public Boolean getTicketPaid() {
        return ticketPaid;
    }

    /**
     * Sets ticket paid.
     *
     * @param ticketPaid the ticket paid
     */
    public void setTicketPaid(Boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    /**
     * Gets description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets description.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
