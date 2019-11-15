package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.utils.CustomDTFormatter;

import java.io.Serializable;
import java.util.Date;

/**
 * The type Custom dt formatter bean.
 */
public class CustomDTFormatterBean implements Serializable {

    private long date = -1L;

    /**
     * Gets date.
     *
     * @return the date
     */
    public long getDate() {
        return date;
    }

    /**
     * Sets date.
     *
     * @param date the date
     */
    public void setDate(long date) {
        this.date = date;
    }

    /**
     * Gets formatted date.
     *
     * @return the formatted date
     */
    public String getFormattedDate() {
        return CustomDTFormatter.formatDate(new Date(date));
    }

    /**
     * Gets formatted time.
     *
     * @return the formatted time
     */
    public String getFormattedTime() {
        return CustomDTFormatter.formatTime(new Date(date));
    }

    /**
     * Gets formatted date time.
     *
     * @return the formatted date time
     */
    public String getFormattedDateTime() {
        return CustomDTFormatter.formatDateTime(new Date(date));
    }

}
