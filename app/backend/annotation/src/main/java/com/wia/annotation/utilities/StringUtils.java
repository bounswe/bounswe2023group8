package com.wia.annotation.utilities;

import java.text.Normalizer;
import java.util.Locale;
import java.util.regex.Pattern;

public class StringUtils {

    public static StringUtils instance;
    static final Pattern NONLATIN = Pattern.compile("[^\\w-]");
    static final Pattern WHITESPACE = Pattern.compile("[\\s]");

    public static StringUtils getInstance() {
        if (instance == null) instance = new StringUtils();
        return instance;
    }

    /**
     * Divides the annotation name and id into two separate strings.
     *
     * @param annotationNameId name+id of the annotation
     * @return                 name of the annotation
     */
    public static String divideFirst(String annotationNameId) {
        return annotationNameId.split("(?<=\\D)(?=\\d)")[0];
    }

    /**
     * Divides the annotation name and id into two separate strings.
     *
     * @param annotationNameId name+id of the annotation
     * @return                 id of the annotation
     */
    public static Long divideSecond(String annotationNameId) {
        try {
            return Long.parseLong(annotationNameId.split("(?<=\\D)(?=\\d)")[1]);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    /**
     * Checks if the given string is an integer.
     *
     * @param number    given string
     * @return          boolean
     */
    public static boolean isInt(String number) {
        try {
            Integer.parseInt(number);
            return true;
        } catch (Exception e) {
            return false;
        }
    }

    /**
     * Converts all characters in the given string to lowercase.
     *
     * @param input    given string
     * @return         slug case string
     */
    public String toSlug(String input) {

        try {
            String noWhitespace = WHITESPACE
                    .matcher(input.trim().toLowerCase(Locale.ENGLISH))
                    .replaceAll("-");
            String normalized = Normalizer.normalize(noWhitespace, Normalizer.Form.NFD);
            String preprocessed = normalized.replace('ı', 'i');

            String replaced = preprocessed
                    .replace('_', '-')
                    .replace("--", "-")
                    .replaceAll("[^a-z0-9\\-<>&]", "")
                    .replaceAll("[\\-&<>]+", "-");

            if (replaced.endsWith("-"))
                replaced = replaced.substring(0, replaced.length() - 1);

            return NONLATIN.matcher(replaced).replaceAll("");
        } catch (Exception ex) {
            return input;
        }
    }

    public static boolean containsDigit(String s) {

        boolean containsDigit = false;

        if (s != null && !s.isEmpty()) {
            for (char c : s.toCharArray()) {
                if (containsDigit = Character.isDigit(c)) {
                    break;
                }
            }
        }

        return containsDigit;
    }
}
