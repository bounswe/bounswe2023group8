package com.bounswe.group8.exception.custom;

public class PageException extends RuntimeException {

    public PageException(String message) {
        super(message);
    }

    public PageException(String message, Throwable cause) {
        super(message, cause);
    }

    public PageException(Throwable cause) {
        super(cause);
    }

    public PageException() {
        super("Page fault.");
    }

}
