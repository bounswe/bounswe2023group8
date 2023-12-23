package com.wia.annotation.utilities;

public class StringUtils {

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
}
