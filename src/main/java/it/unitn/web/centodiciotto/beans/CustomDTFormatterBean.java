package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.utils.CustomDTFormatter;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;

public class CustomDTFormatterBean implements Serializable {

    private Date date = null;

    public Date getDate() {
        return date;
    }

    public void setDate(java.util.Date date) {
        this.date = date;
    }

    public void setDate(Timestamp ts) {
        this.date = new Date(ts.getTime());
    }

    public void setDate(java.sql.Date date) {
        this.date = new Date(date.getTime());
    }

    public String getFormattedDate() {
        return CustomDTFormatter.formatDate(date);
    }

    public String getFormattedTime() {
        return CustomDTFormatter.formatTime(date);
    }

    public String getFormattedDateTime() {
        return CustomDTFormatter.formatDateTime(date);
    }

}
