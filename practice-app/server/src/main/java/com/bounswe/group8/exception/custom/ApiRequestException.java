package com.bounswe.group8.exception.custom;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;

public class ApiRequestException extends RuntimeException {

    @Value("${api.request.error.message}")
    String defaultMessage;

    HttpStatus httpStatus;

    public ApiRequestException(String message, Integer statusCode) {
        super(message);
    }

    public ApiRequestException(String message, Throwable cause) {
        super(message, cause);
    }

    public ApiRequestException() {
        super();
    }

    public HttpStatus getHttpStatus() {
        return httpStatus;
    }
}
