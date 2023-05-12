package com.bounswe.group8.exception;

import com.bounswe.group8.exception.custom.DuplicateResourceException;
import com.bounswe.group8.exception.custom.ResourceNotFoundException;
import com.bounswe.group8.payload.response.ErrorResponse;
import jakarta.persistence.EntityNotFoundException;
import jakarta.servlet.http.HttpServletResponse;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.dao.DataAccessException;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

import java.security.SignatureException;
import java.util.List;
import java.util.NoSuchElementException;
import java.util.Objects;
import java.util.stream.Collectors;

import static org.springframework.http.HttpStatus.*;
import static org.springframework.http.HttpStatus.BAD_REQUEST;

@ControllerAdvice
public class GlobalExceptionHandler {

    @Value("${database.error.message}")
    String daoExceptionMessage;

    @ExceptionHandler(DataAccessException.class)
    public ResponseEntity<ErrorResponse> repositoryLayerException(
            DataAccessException ignoredEx) {

        return new ResponseEntity<>(
                new ErrorResponse(INTERNAL_SERVER_ERROR, "dao-layer-error", daoExceptionMessage),
                INTERNAL_SERVER_ERROR
        );
    }

    @ResponseStatus(CONFLICT)
    @ExceptionHandler(DuplicateResourceException.class)
    public ResponseEntity<ErrorResponse> duplicateResourceException(
            HttpServletResponse response,
            DuplicateResourceException ex) {

        response.setStatus(CONFLICT.value());

        return new ResponseEntity<>(
                new ErrorResponse(CONFLICT, "duplicate-resource", ex.getMessage()),
                CONFLICT
        );
    }

    @ExceptionHandler(ResourceNotFoundException.class)
    public ResponseEntity<ErrorResponse> resourceNotFoundException(
            ResourceNotFoundException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(NOT_FOUND, "resource-not-found", ex.getMessage()),
                NOT_FOUND
        );
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> illegalArgumentException(
            IllegalArgumentException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(BAD_REQUEST, "illegal-argument", ex.getMessage()),
                BAD_REQUEST
        );
    }

    @ExceptionHandler(NoSuchElementException.class)
    public ResponseEntity<ErrorResponse> noSuchElementException(
            NoSuchElementException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(BAD_REQUEST, "not-found", ex.getMessage()),
                BAD_REQUEST
        );
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> globalException(
            Exception ex) {

        return new ResponseEntity<>(
                new ErrorResponse(INTERNAL_SERVER_ERROR, "internal-server-error", ex.getMessage(), ex),
                INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler({SignatureException.class, java.security.SignatureException.class})
    public ResponseEntity<ErrorResponse> signatureException(
            SignatureException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(UNAUTHORIZED, "signature-error", ex.getMessage()),
                UNAUTHORIZED
        );
    }

    @ExceptionHandler(EntityNotFoundException.class)
    protected ResponseEntity<Object> handleEntityNotFound(
            EntityNotFoundException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(NOT_FOUND, "entity-not-found", ex.getMessage()),
                NOT_FOUND
        );
    }

    @ExceptionHandler(DataIntegrityViolationException.class)
    protected ResponseEntity<ErrorResponse> handleDataIntegrityViolation(
            DataIntegrityViolationException ex) {

        if (ex.getCause() instanceof ConstraintViolationException)
            return new ResponseEntity<>(
                    new ErrorResponse(CONFLICT, "constraint-violation", ex.getMessage()),
                    CONFLICT
            );

        return new ResponseEntity<>(
                new ErrorResponse(INTERNAL_SERVER_ERROR, "data-integrity-violation", ex.getMessage(), ex),
                INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler(MethodArgumentTypeMismatchException.class)
    protected ResponseEntity<Object> handleMethodArgumentTypeMismatch(
            MethodArgumentTypeMismatchException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(BAD_REQUEST, "method-argument-type-mismatch",
                        String.format("The parameter '%s' of value '%s' could not be converted to type '%s'",
                                ex.getName(), ex.getValue(), Objects.requireNonNull(ex.getRequiredType()).getSimpleName()),
                        ex),
                BAD_REQUEST
        );
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    protected ResponseEntity<Object> handleMethodArgumentNotValid(
            MethodArgumentNotValidException ex) {

        List<String> validationErrors = ex.getBindingResult().getFieldErrors().stream()
                .map(fieldError -> String.format("%s: %s", fieldError.getField(), fieldError.getDefaultMessage()))
                .collect(Collectors.toList());

        return new ResponseEntity<>(
                new ErrorResponse(BAD_REQUEST, "method-argument-not-valid",
                        "Payload field(s) did not pass validation.",
                        validationErrors),
                BAD_REQUEST
        );
    }

    @ExceptionHandler(IllegalStateException.class)
    protected ResponseEntity<Object> handleIllegalState(
            IllegalStateException ex) {

        return new ResponseEntity<>(
                new ErrorResponse(BAD_REQUEST, "illegal-state", ex.getMessage(), ex),
                BAD_REQUEST
        );
    }

}
