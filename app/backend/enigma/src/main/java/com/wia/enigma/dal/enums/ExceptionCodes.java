package com.wia.enigma.dal.enums;

public enum ExceptionCodes {

    INTERNAL_SERVER_ERROR(1, "Internal server error"),
    USER_NOT_FOUND(100, "Enigma user not found"),
    NULL_POINTER(69, "Unexpected generic error occurred"),
    INVALID_DATE_FORMAT(600, "Invalid date format"),
    INVALID_AUDIENCE_TYPE(601, "Invalid audience type"),
    INVALID_JWT(602, "Invalid JWT"),
    INVALID_JWT_CLAIM(603, "Invalid JWT claim"),
    INVALID_JWT_SIGNATURE(604, "Invalid JWT signature"),
    INVALID_JWT_EXPIRATION(605, "Invalid JWT expiration"),
    INVALID_JWT_ISSUED_AT(606, "Invalid JWT issued at"),
    INVALID_JWT_AUDIENCE(607, "Invalid JWT audience"),
    INVALID_JWT_ISSUER(608, "Invalid JWT issuer"),
    INVALID_JWT_ID(609, "Invalid JWT ID"),
    INVALID_JWT_SUBJECT(610, "Invalid JWT subject"),
    INVALID_JWT_TYPE(611, "Invalid JWT type"),
    INVALID_USERNAME(612, "Invalid username"),
    INVALID_PASSWORD(613, "Invalid password"),
    REVOKED_JWT(614, "Revoked JWT"),

    VERIFICATION_TOKEN_NOT_FOUND(615, "Verification token not found"),
    VERIFICATION_TOKEN_EXPIRED(616, "Verification token expired"),

    PASSWORDS_DO_NOT_MATCH(617, "Passwords do not match"),

    USERNAME_OR_EMAIL_ALREADY_VERIFIED(618, "Username or email exists."),

    DB_GET_ERROR(700, "Error while getting data from database"),
    DB_SAVE_ERROR(701, "Error while saving data to database"),
    DB_UPDATE_ERROR(702, "Error while updating data in database"),
    DB_DELETE_ERROR(703, "Error while deleting data from database"),
    DB_UNIQUE_CONSTRAINT_VIOLATION(704, "Unique constraint violation"),
    DB_CONSTRAINT_VIOLATION(705, "Constraint violation"),
    MISSING_AUTHORIZATION_HEADER(800, "Missing Authorization header"),
    INVALID_AUTHORIZATION_HEADER(801, "Invalid Authorization header");

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
