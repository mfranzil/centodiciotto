package it.unitn.web.centodiciotto.beans;

import it.unitn.web.centodiciotto.utils.CustomDTFormatter;

import java.io.Serializable;
import java.util.Date;

public class CustomDTFormatterBean implements Serializable {

    private long date = -1L;

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
    }

    public String getFormattedDate() {
        return CustomDTFormatter.formatDate(new Date(date));
    }

    public String getFormattedTime() {
        return CustomDTFormatter.formatTime(new Date(date));
    }

    public String getFormattedDateTime() {
        return CustomDTFormatter.formatDateTime(new Date(date));
    }

}
