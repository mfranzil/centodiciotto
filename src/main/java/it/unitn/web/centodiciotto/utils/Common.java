package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.persistence.entities.*;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Arrays;
import java.util.Date;

public class Common {
    public static boolean containsItemFromArray(String inputString, String[] items) {
        return Arrays.stream(items).anyMatch(inputString::contains);
    }

    public static String getDisplayName(User user) {
        String displayName;
        if (user instanceof Patient) {
            displayName = ((Patient) user).getFirstName();
        } else if (user instanceof GeneralPractitioner) {
            displayName = ((GeneralPractitioner) user).getFirstName();
        } else if (user instanceof SpecializedDoctor) {
            displayName = ((SpecializedDoctor) user).getFirstName();
        } else if (user instanceof Chemist) {
            displayName = ((Chemist) user).getName();
        } else if (user instanceof HealthService) {
            displayName = ((HealthService) user).getOperatingProvince().getName() + " HS";
        } else {
            displayName = "default";
        }
        return displayName;
    }

    public static boolean isWithinAgeRange(Date date, Integer minAge, Integer maxAge) {
        ZoneId zoneId = ZoneId.systemDefault();

        long minAgeLong = LocalDate.now().minusYears(minAge).atStartOfDay(zoneId).toEpochSecond();
        long maxAgeLong = LocalDate.now().minusYears(maxAge).atStartOfDay(zoneId).toEpochSecond();
        long dateLong = date.getTime() / 1000;

        return dateLong <= minAgeLong && dateLong >= maxAgeLong;
    }
}
