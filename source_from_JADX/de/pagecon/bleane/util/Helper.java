package de.pagecon.bleane.util;

import java.util.Locale;

public class Helper {
    public static boolean stringEqualsIgnoreCase(String s1, String s2) {
        if (s1 == null || s2 == null || !s1.toLowerCase(Locale.US).equals(s2.toLowerCase(Locale.US))) {
            return false;
        }
        return true;
    }
}
