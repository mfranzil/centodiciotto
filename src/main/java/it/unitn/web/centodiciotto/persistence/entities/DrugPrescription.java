package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * DrugPrescription entity that represents a potential medicine sold by a {@link Chemist} to a {@link Patient}.
 * <p>
 * It must be prescribed by a {@link GeneralPractitioner}.
 */
public class DrugPrescription {
    private Integer ID;
    private String practitionerID;
    private String patientID;
    private DrugType type;
    private Timestamp datePrescribed;
    private Timestamp dateSold;
    private String chemistID;
    private Integer ticket;
    private Boolean ticketPaid;
    private String description;

    /**
     * Gets the ID.
     *
     * @return the ID
     */
    public Integer getID() {
        return ID;
    }

    /**
     * Sets the ID.
     *
     * @param ID the ID
     */
    public void setID(Integer ID) {
        this.ID = ID;
    }

    /**
     * Gets the practitionerID
     *
     * @return the practitionerID
     */
    public String getPractitionerID() {
        return practitionerID;
    }

    /**
     * Sets the practitionerID
     *
     * @param practitionerID the practitionerID
     */
    public void setPractitionerID(String practitionerID) {
        this.practitionerID = practitionerID;
    }

    /**
     * Gets the patientID.
     *
     * @return the patientID
     */
    public String getPatientID() {
        return patientID;
    }

    /**
     * Sets the patientID.
     *
     * @param patientID the patientID
     */
    public void setPatientID(String patientID) {
        this.patientID = patientID;
    }

    /**
     * Gets the drug type.
     *
     * @return the drug type
     */
    public DrugType getType() {
        return type;
    }

    /**
     * Sets the drug type.
     *
     * @param type the drug type
     */
    public void setType(DrugType type) {
        this.type = type;
    }

    /**
     * Gets the date prescribed.
     *
     * @return the date prescribed
     */
    public Timestamp getDatePrescribed() {
        return datePrescribed;
    }

    /**
     * Sets the date prescribed.
     *
     * @param datePrescribed the date prescribed
     */
    public void setDatePrescribed(Timestamp datePrescribed) {
        this.datePrescribed = datePrescribed;
    }

    /**
     * Gets the date sold.
     *
     * @return the date sold
     */
    public Timestamp getDateSold() {
        return dateSold;
    }

    /**
     * Sets the date sold.
     *
     * @param dateSold the date sold
     */
    public void setDateSold(Timestamp dateSold) {
        this.dateSold = dateSold;
    }

    /**
     * Gets the chemistID.
     *
     * @return the chemistID
     */
    public String getChemistID() {
        return chemistID;
    }

    /**
     * Sets the chemistID.
     *
     * @param chemistID the chemistID
     */
    public void setChemistID(String chemistID) {
        this.chemistID = chemistID;
    }

    /**
     * Gets the ticket.
     *
     * @return the ticket
     */
    public Integer getTicket() {
        return ticket;
    }

    /**
     * Sets the ticket.
     *
     * @param ticket the ticket
     */
    public void setTicket(Integer ticket) {
        this.ticket = ticket;
    }

    /**
     * Gets the ticket paid.
     *
     * @return the ticket paid
     */
    public Boolean getTicketPaid() {
        return ticketPaid;
    }

    /**
     * Sets the ticket paid.
     *
     * @param ticketPaid the ticket paid
     */
    public void setTicketPaid(Boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    /**
     * Gets the description.
     *
     * @return the description
     */
    public String getDescription() {
        return description;
    }

    /**
     * Sets the description.
     *
     * @param description the description
     */
    public void setDescription(String description) {
        this.description = description;
    }
}
