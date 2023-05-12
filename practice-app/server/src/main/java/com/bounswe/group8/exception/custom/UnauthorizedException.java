package com.bounswe.group8.exception.custom;

public class UnauthorizedException extends RuntimeException {

    public UnauthorizedException(String message) {
        super(message);
    }

    public UnauthorizedException(String message, Throwable cause) {
        super(message, cause);
    }

    public UnauthorizedException(Throwable cause) {
        super(cause);
    }

    public UnauthorizedException() {
        super("Unauthorized");
    }

    public UnauthorizedException(String type, String field, String value) {
        super(String.format("Unauthorized %s not found with %s: %s", type, field, value));
    }
}
