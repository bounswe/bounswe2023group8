package com.wia.enigma.dal.enums;

import java.util.Set;

public enum AudienceType {

    USER("user"),
    ADMIN("admin");

    private final String name;

    AudienceType(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public static AudienceType fromString(String text) {
        for (AudienceType b : AudienceType.values()) {
            if (b.name.equalsIgnoreCase(text)) {
                return b;
            }
        }
        return null;
    }

    public static AudienceType fromAudienceSet(Set<String> audienceSet) {

        if (audienceSet == null || audienceSet.size() != 1)
            return null;

        for (AudienceType b : AudienceType.values()) {
            if (audienceSet.contains(b.name)) {
                return b;
            }
        }
        return null;
    }

    public static String getTypes() {
        StringBuilder sb = new StringBuilder();
        sb.append("[");
        for (AudienceType b : AudienceType.values()) {
            sb.append(b.name).append(", ");
        }
        sb.delete(sb.length() - 2, sb.length());
        sb.append("]");
        return sb.toString();
    }
}
