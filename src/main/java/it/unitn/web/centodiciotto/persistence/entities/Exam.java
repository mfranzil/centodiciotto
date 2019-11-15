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
     * Gets doctor id.
     *
     * @return the doctor id
     */
    public String getDoctorID() {
        return doctorID;
    }

    /**
     * Sets doctor id.
     *
     * @param doctorID the doctor id
     */
    public void setDoctorID(String doctorID) {
        this.doctorID = doctorID;
    }

    /**
     * Gets type.
     *
     * @return the type
     */
    public ExamType getType() {
        return type;
    }

    /**
     * Sets type.
     *
     * @param type the type
     */
    public void setType(ExamType type) {
        this.type = type;
    }

    /**
     * Gets done.
     *
     * @return the done
     */
    public Boolean getDone() {
        return done;
    }

    /**
     * Sets done.
     *
     * @param done the done
     */
    public void setDone(Boolean done) {
        this.done = done;
    }

    /**
     * Gets date.
     *
     * @return the date
     */
    public Timestamp getDate() {
        return date;
    }

    /**
     * Sets date.
     *
     * @param date the date
     */
    public void setDate(Timestamp date) {
        this.date = date;
    }

    /**
     * Gets result.
     *
     * @return the result
     */
    public String getResult() {
        return result;
    }

    /**
     * Sets result.
     *
     * @param result the result
     */
    public void setResult(String result) {
        this.result = result;
    }

    /**
     * Gets health service id.
     *
     * @return the health service id
     */
    public String getHealthServiceID() {
        return healthServiceID;
    }

    /**
     * Sets health service id.
     *
     * @param healthServiceID the health service id
     */
    public void setHealthServiceID(String healthServiceID) {
        this.healthServiceID = healthServiceID;
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
     * Is ticket paid boolean.
     *
     * @return the boolean
     */
    public boolean isTicketPaid() {
        return ticketPaid;
    }

    /**
     * Sets ticket paid.
     *
     * @param ticketPaid the ticket paid
     */
    public void setTicketPaid(boolean ticketPaid) {
        this.ticketPaid = ticketPaid;
    }

    /**
     * Gets recall.
     *
     * @return the recall
     */
    public Integer getRecall() {
        return recall;
    }

    /**
     * Sets recall.
     *
     * @param recall the recall
     */
    public void setRecall(Integer recall) {
        this.recall = recall;
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
     * Is booked boolean.
     *
     * @return the boolean
     */
    public boolean isBooked() {
        return booked;
    }

    /**
     * Sets booked.
     *
     * @param booked the booked
     */
    public void setBooked(boolean booked) {
        this.booked = booked;
    }
}
