package com.bounswe.group8.utils.enums;

public enum PortfolioUserRole {

    OWNER("owner"),

    EDITOR("editor"),

    VIEWER("viewer");

    private final String role;

    public String getRole() {
        return role;
    }

    PortfolioUserRole(String role) {
        this.role = role;
    }

    @Override
    public String toString() {
        return role;
    }

}
