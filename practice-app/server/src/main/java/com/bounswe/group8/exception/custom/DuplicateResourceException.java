package com.bounswe.group8.exception.custom;

import org.springframework.beans.factory.annotation.Value;

public class DuplicateResourceException extends RuntimeException {

    @Value("${duplicate.resource.error.message}")
    String defaultMessage;

    public DuplicateResourceException(String message) {
        super(message);
    }

    public DuplicateResourceException(String message, Throwable cause) {
        super(message, cause);
    }

    public DuplicateResourceException() {
        super();
    }

}

