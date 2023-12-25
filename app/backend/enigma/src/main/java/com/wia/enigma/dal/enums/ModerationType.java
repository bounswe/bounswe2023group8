package com.wia.enigma.dal.enums;


import lombok.Getter;

@Getter
public enum ModerationType {

    WARNING("warning"),
    BAN("ban"),
    REPORT("report");

    private final String type;

    ModerationType(String type) {
        this.type = type;
    }

    public static ModerationType fromString(String type) {
        for (ModerationType moderationType : ModerationType.values()) {
            if (moderationType.getType().equalsIgnoreCase(type)) {
                return moderationType;
            }
        }
        return null;
    }
}
