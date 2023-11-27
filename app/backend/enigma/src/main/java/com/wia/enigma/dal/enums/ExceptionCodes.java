package com.wia.enigma.dal.enums;

public enum ExceptionCodes {

    // General Errors
    INTERNAL_SERVER_ERROR(1, "Internal server error"),
    NULL_POINTER(2, "Unexpected generic error occurred"),

    // User Related Errors
    USER_NOT_FOUND(100, "Enigma user not found"),
    USERNAME_OR_EMAIL_ALREADY_VERIFIED(101, "Username or email exists."),
    INVALID_USERNAME(102, "Invalid username"),
    INVALID_PASSWORD(103, "Invalid password"),
    PASSWORDS_DO_NOT_MATCH(104, "Passwords do not match"),

    INVALID_NESTED_INTEREST_AREA_IDS(105, "Invalid nested interest area ids"),

    INVALID_REQUEST(106, "Invalid request"),

    // Interest Area Related Errors
    INTEREST_AREA_NOT_FOUND(200, "Interest area not found"),

    ENTITY_NOT_FOUND(200, "Entity not found"),
    INVALID_WIKI_TAG_ID(201, "Invalid wiki tag id"),

    // JWT Related Errors
    INVALID_JWT(300, "Invalid JWT"),
    INVALID_JWT_CLAIM(301, "Invalid JWT claim"),
    INVALID_JWT_SIGNATURE(302, "Invalid JWT signature"),
    INVALID_JWT_EXPIRATION(303, "Invalid JWT expiration"),
    INVALID_JWT_ISSUED_AT(304, "Invalid JWT issued at"),
    INVALID_JWT_AUDIENCE(305, "Invalid JWT audience"),
    INVALID_JWT_ISSUER(306, "Invalid JWT issuer"),
    INVALID_JWT_ID(307, "Invalid JWT ID"),
    INVALID_JWT_SUBJECT(308, "Invalid JWT subject"),
    INVALID_JWT_TYPE(309, "Invalid JWT type"),
    REVOKED_JWT(310, "Revoked JWT"),

    // Verification Token Errors
    VERIFICATION_TOKEN_NOT_FOUND(400, "Verification token not found"),
    VERIFICATION_TOKEN_EXPIRED(401, "Verification token expired"),

    // Database Related Errors
    DB_GET_ERROR(500, "Error while getting data from database"),
    DB_SAVE_ERROR(501, "Error while saving data to database"),
    DB_UPDATE_ERROR(502, "Error while updating data in database"),
    DB_DELETE_ERROR(503, "Error while deleting data from database"),
    DB_UNIQUE_CONSTRAINT_VIOLATION(504, "Unique constraint violation"),
    DB_CONSTRAINT_VIOLATION(505, "Constraint violation"),

    // Authentication and Authorization Errors
    MISSING_AUTHORIZATION_HEADER(600, "Missing Authorization header"),
    INVALID_AUTHORIZATION_HEADER(601, "Invalid Authorization header"),

    NON_AUTHORIZED_ACTION(619, "Non-authorized action"),

    // External API Errors
    API_RETURNED_NON_200(700, "API returned non-200 status code"),

    // Date and Format Validation
    INVALID_DATE_FORMAT(800, "Invalid date format"),
    INVALID_AUDIENCE_TYPE(801, "Invalid audience type");

    private final int code;
    private final String message;

    ExceptionCodes(int code, String message) {
        this.code = code;
        this.message = message;
    }

    public int getCode() {
        return this.code;
    }

    public String getMessage() {
        return this.message;
    }
}
