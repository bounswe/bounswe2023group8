package com.bounswe.group8.exception.custom;

public class ResourceNotFoundException extends RuntimeException {

    public ResourceNotFoundException(String message) {
        super(message);
    }

    public ResourceNotFoundException(String message, Throwable cause) {
        super(message, cause);
    }

    public ResourceNotFoundException(Throwable cause) {
        super(cause);
    }

    public ResourceNotFoundException() {
        super("Resource not found");
    }

    public ResourceNotFoundException(String type, String field, String value) {
        super(String.format("Resource %s not found with %s: %s", type, field, value));
    }

}
