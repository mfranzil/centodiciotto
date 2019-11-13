package it.unitn.web.centodiciotto.utils;

import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.Locale;

public class CustomDTFormatter {
    public static String formatDate(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, YYYY").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    public static String formatTime(Date date) {
        return DateTimeFormatter.ofPattern("HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }

    public static String formatDateTime(Date date) {
        return DateTimeFormatter.ofPattern("MMMM d, YYYY HH:mm").withLocale(Locale.UK)
                .withZone(ZoneId.systemDefault()).format(date.toInstant());
    }
}
