package it.unitn.web.centodiciotto.utils;

import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

/**
 * Auxiliary class for system-wide date and time formatting.
 * <p>
 * Used by {@link it.unitn.web.centodiciotto.beans.CustomDTFormatterBean}, which is a wrapper.
 */
public class CustomDTFormatter {

    /**
     * Gets a date-only representation of the time since epoch.
     * <p>
     * The Date is formatted as "MMMM dd, yyyy" (example: December 19, 2000)
     *
     * @return the formatted date
     */
    public static String formatDate(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, yyyy").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    /**
     * Gets a time-only representation of the time since epoch.
     * <p>
     * The time is formatted as "HH:MM" in 24H format (example: 20:05)
     *
     * @return the formatted time
     */
    public static String formatTime(Date date) {
        return DateTimeFormatter.ofPattern("HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    /**
     * Gets a date and time representation of the time since epoch.
     * <p>
     * The Date is formatted as "MMMM dd, yyyy HH:MM" with the time in 24H format (example: December 19, 2000 20:05)
     *
     * @return the formatted date time
     */
    public static String formatDateTime(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, yyyy HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    /**
     * Gets a date and time representation of the time since epoch with an arbitrary formatting.
     *
     * @param date the date
     * @param format the format string (see {@link DateTimeFormatter})
     * @return the formatted date time
     */
    public static String formatCustom(Date date, String format) {
        return DateTimeFormatter.ofPattern(format).withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }
}
