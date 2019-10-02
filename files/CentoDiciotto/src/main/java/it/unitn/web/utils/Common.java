package it.unitn.web.utils;

import java.util.Arrays;

public class Common {
    public static boolean containsItemFromArray(String inputString, String[] items) {
        return Arrays.stream(items).anyMatch(inputString::contains);
    }
}
