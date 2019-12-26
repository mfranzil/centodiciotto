package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.utils.CustomDTFormatter;

import java.io.Serializable;
import java.util.Date;

/**
 * JavaBean for standardized Date/Time formatting across the application.
 */
public class CustomDTFormatterBean implements Serializable {

    private long date = -1L;

    /**
     * Gets the time since epoch associated to this Bean.
     *
     * @return the time since epoch associated to this Bean
     */
    public long getDate() {
        return date;
    }

    /**
     * Sets the time since epoch associated to this Bean.
     *
     * @param date the time since epoch associated to this Bean
     */
    public void setDate(long date) {
        this.date = date;
    }

    /**
     * Gets a date-only representation of the time since epoch.
     * <p>
     * The Date is formatted as "MMMM dd, yyyy" (example: December 19, 2000)
     *
     * @return the formatted date
     */
    public String getFormattedDate() {
        return CustomDTFormatter.formatDate(new Date(date));
    }

    /**
     * Gets a time-only representation of the time since epoch.
     * <p>
     * The time is formatted as "HH:MM" in 24H format (example: 20:05)
     *
     * @return the formatted time
     */
    public String getFormattedTime() {
        return CustomDTFormatter.formatTime(new Date(date));
    }

    /**
     * Gets a date and time representation of the time since epoch.
     * <p>
     * The Date is formatted as "MMMM dd, yyyy HH:MM" with the time in 24H format (example: December 19, 2000 20:05)
     *
     * @return the formatted date time
     */
    public String getFormattedDateTime() {
        return CustomDTFormatter.formatDateTime(new Date(date));
    }

}
