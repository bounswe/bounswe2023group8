package com.wia.enigma.dal.enums;

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
}
