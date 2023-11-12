package com.wia.enigma.dal.enums;

public enum EntityType {

    INTEREST_AREA("interest_area"),
    POST("post");

    private final String name;

    EntityType(String name) {
        this.name = name;
    }
}
