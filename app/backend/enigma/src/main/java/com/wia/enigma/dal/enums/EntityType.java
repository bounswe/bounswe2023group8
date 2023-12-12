package com.wia.enigma.dal.enums;

public enum EntityType {

    INTEREST_AREA("interest_area"),
    POST("post"),
    USER("user");

    private final String name;

    EntityType(String name) {
        this.name = name;
    }

    public static EntityType fromValue(String value) {
        for (EntityType e : EntityType.values()) {
            if (e.name.equals(value)) {
                return e;
            }
        }
        throw new IllegalArgumentException(value);
    }
}
