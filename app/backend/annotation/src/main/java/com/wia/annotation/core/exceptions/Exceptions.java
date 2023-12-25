package com.wia.annotation.core.exceptions;

public enum Exceptions {

    GENERIC_ERROR(0, "Generic error"),
    BAD_REQUEST(1, "Bad request"),
    UNAUTHORIZED(2, "Unauthorized"),
    FORBIDDEN(3, "Forbidden"),
    NOT_FOUND(4, "Not found"),
    METHOD_NOT_ALLOWED(5, "Method not allowed"),
    NOT_ACCEPTABLE(6, "Not acceptable"),
    REQUEST_TIMEOUT(7, "Request timeout"),
    CONFLICT(8, "Conflict"),
    GONE(9, "Gone"),
    BAD_REQUEST_PARAMETER(10, "Bad request parameter"),
    MISSING_REQUIRED_QUERY_PARAMETER(11, "Missing required query parameter"),

    DB_FETCH_ERROR(1000, "Error while fetching data from database"),
    DB_INSERT_ERROR(1001, "Error while inserting data into database"),
    DB_SAVE_ERROR(1002, "Error while updating data into database"),
    DB_DELETE_ERROR(1003, "Error while deleting data from database"),
    DB_DUPLICATE_ERROR(1004, "Duplicate data in database");

    private final int id;
    private final String message;

    Exceptions(int id, String message) {
        this.id = id;
        this.message = message;
    }

    public int getId() {
        return this.id;
    }

    public String getMessage() {
        return this.message;
    }
}
