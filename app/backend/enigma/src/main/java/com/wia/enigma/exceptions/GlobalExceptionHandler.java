package com.wia.enigma.exceptions;

import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(EnigmaException.class)
    public ResponseEntity<Object> handleEnigmaException(EnigmaException ex) {
        HttpStatus status = determineHttpStatus(ex.getExceptionCode());
        ApiError apiError = new ApiError(ex.getExceptionCode().getCode(), ex.getMessage());
        return new ResponseEntity<>(apiError, status);
    }

    private HttpStatus determineHttpStatus(ExceptionCodes code) {
        switch (code) {
            case INTERNAL_SERVER_ERROR:
                return HttpStatus.INTERNAL_SERVER_ERROR;
            case USER_NOT_FOUND:
            case INTEREST_AREA_NOT_FOUND:
            case ENTITY_NOT_FOUND:
            case VERIFICATION_TOKEN_NOT_FOUND:
                return HttpStatus.NOT_FOUND;
            case NULL_POINTER:
            case INVALID_DATE_FORMAT:
            case INVALID_AUDIENCE_TYPE:
            case INVALID_USERNAME:
            case INVALID_PASSWORD:
            case PASSWORDS_DO_NOT_MATCH:
            case INVALID_REQUEST:
            case INVALID_NESTED_INTEREST_AREA_IDS:
            case INVALID_WIKI_TAG_ID:
                return HttpStatus.BAD_REQUEST;
            case INVALID_JWT:
            case INVALID_JWT_CLAIM:
            case INVALID_JWT_SIGNATURE:
            case INVALID_JWT_EXPIRATION:
            case INVALID_JWT_ISSUED_AT:
            case INVALID_JWT_AUDIENCE:
            case INVALID_JWT_ISSUER:
            case INVALID_JWT_ID:
            case INVALID_JWT_SUBJECT:
            case INVALID_JWT_TYPE:
            case REVOKED_JWT:
            case MISSING_AUTHORIZATION_HEADER:
            case INVALID_AUTHORIZATION_HEADER:
                return HttpStatus.UNAUTHORIZED;
            case VERIFICATION_TOKEN_EXPIRED:
                return HttpStatus.GONE;
            case USERNAME_OR_EMAIL_ALREADY_VERIFIED:
                return HttpStatus.CONFLICT;
            case DB_GET_ERROR:
            case DB_SAVE_ERROR:
            case DB_UPDATE_ERROR:
            case DB_DELETE_ERROR:
            case DB_UNIQUE_CONSTRAINT_VIOLATION:
            case DB_CONSTRAINT_VIOLATION:
                return HttpStatus.INTERNAL_SERVER_ERROR;
            case API_RETURNED_NON_200:
                return HttpStatus.SERVICE_UNAVAILABLE;
            case NON_AUTHORIZED_ACTION:
                return HttpStatus.FORBIDDEN;
            default:
                return HttpStatus.BAD_REQUEST;
        }
    }
}
