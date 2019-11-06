package it.unitn.web.centodiciotto.utils;

import it.unitn.web.centodiciotto.persistence.entities.*;

import java.util.Arrays;

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
            displayName = ((HealthService) user).getOperatingProvince().getName() + " Health Service";
        } else {
            displayName = "default";
        }
        return displayName;
    }
}
