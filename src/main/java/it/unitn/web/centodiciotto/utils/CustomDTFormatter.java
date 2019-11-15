package it.unitn.web.centodiciotto.utils;

import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

/**
 * The type Custom dt formatter.
 */
public class CustomDTFormatter {
    /**
     * Format date string.
     *
     * @param date the date
     * @return the string
     */
    public static String formatDate(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, YYYY").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    /**
     * Format time string.
     *
     * @param date the date
     * @return the string
     */
    public static String formatTime(Date date) {
        return DateTimeFormatter.ofPattern("HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    /**
     * Format date time string.
     *
     * @param date the date
     * @return the string
     */
    public static String formatDateTime(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, YYYY HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }
}
