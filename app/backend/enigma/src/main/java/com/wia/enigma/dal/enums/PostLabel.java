package com.wia.enigma.dal.enums;

public enum PostLabel  {

    DOCUMENTATION("documentation"),
    LEARNING("learning"),
    NEWS("news"),
    RESEARCH("research"),
    DISCUSSION("discussion");

    private final String name;

    PostLabel(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }
}
