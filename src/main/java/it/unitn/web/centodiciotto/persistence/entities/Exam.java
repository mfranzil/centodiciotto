package it.unitn.web.centodiciotto.persistence.entities;

import java.sql.Timestamp;

/**
 * The type Exam.
 */
public class Exam {
    private Integer ID;
    private String patientID;
    private String doctorID;
    private ExamType type;
    private Boolean done;
    private Timestamp date;
    private String result;
    private String healthServiceID;
    private Integer ticket;
    private boolean ticketPaid;
    private Integer recall;
    private String practitionerID;
    private boolean booked;

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
     * Gets the doctorID
     *
     * @return the doctorID
     */
    public String getDoctorID() {
        return doctorID;
    }

    /**
     * Sets the doctorID
     *
     * @param doctorID the doctorID
     */
    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    /**
     * Gets the type.
     *
     * @return the type
     */
    public ExamType getType() {
        return type;
    }

    /**
     * Sets the type.
     *
     * @param type the type
     */
    public void setType(ExamType type) {
        this.type = type;
    }

    /**
     * Gets the done.
     *
     * @return the done
     */
    public Boolean getDone() {
        return done;
    }

    /**
     * Sets the done.
     *
     * @param done the done
     */
    public void setDone(Boolean done) {
        this.done = done;
    }

    /**
     * Gets the date.
     *
     * @return the date
     */
    public Timestamp getDate() {
        return date;
    }

    /**
     * Sets the date.
     *
     * @param date the date
     */
    public void setDate(Timestamp date) {
        this.date = date;
    }

    /**
     * Gets the result.
     *
     * @return the result
     */
    public String getResult() {
        return result;
    }

    /**
     * Sets the result.
     *
     * @param result the result
     */
    public void setResult(String result) {
        this.result = result;
    }

    /**
     * Gets the health serviceID.
     *
     * @return the health serviceID
     */
    public String getHealthServiceID() {
        return healthServiceID;
    }

    /**
     * Sets the health serviceID.
     *
     * @param healthServiceID the health serviceID
     */
    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
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
     * Is ticket paid boolean.
     *
     * @return the boolean
     */
    public boolean isTicketPaid() {
        return ticketPaid;
    }

    /**
     * Sets the ticket paid.
     *
     * @param ticketPaid the ticket paid
     */
    public void setTicketPaid(boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    /**
     * Gets the recall.
     *
     * @return the recall
     */
    public Integer getRecall() {
        return recall;
    }

    /**
     * Sets the recall.
     *
     * @param recall the recall
     */
    public void setRecall(Integer recall) {
        this.recall = recall;
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
     * Is booked boolean.
     *
     * @return the boolean
     */
    public boolean isBooked() {
        return booked;
    }

    /**
     * Sets the booked.
     *
     * @param booked the booked
     */
    public void setBooked(boolean booked) {
        this.booked = booked;
    }
}
