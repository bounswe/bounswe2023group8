package com.wia.enigma.dal.enums;


public enum EnigmaAccessLevel {

    PUBLIC("public"),
    PRIVATE("private"),
    PERSONAL("personal");

    private final String name;
    EnigmaAccessLevel(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
