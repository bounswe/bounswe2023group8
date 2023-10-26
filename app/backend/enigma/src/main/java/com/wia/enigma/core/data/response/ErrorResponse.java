package com.wia.enigma.core.data.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.util.List;

@Data
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ErrorResponse {

    Integer code;

    String message;

    List<Error> errors;

    Timestamp timestamp;

    @Data
    @AllArgsConstructor
    public static class Error {

        String field;

        String message;
    }

    public ErrorResponse() {
        this.timestamp = new Timestamp(System.currentTimeMillis());
    }

    public ErrorResponse(Integer code, String message) {
        this();
        this.code = code;
        this.message = message;
    }

    public ErrorResponse(Integer code, String message, List<Error> errors) {
        this(code, message);
        this.errors = errors;
    }
}
