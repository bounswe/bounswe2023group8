package com.bounswe.group8.exception.custom;

import org.springframework.beans.factory.annotation.Value;

public class AlreadyInUseException extends RuntimeException {

    @Value("${already.in.use.error.message}")
    String defaultMessage;

    public AlreadyInUseException(String message) {
        super(message);
    }

    public AlreadyInUseException(String message, Throwable cause) {
        super(message, cause);
    }

    public AlreadyInUseException() {
        super();
    }
}
