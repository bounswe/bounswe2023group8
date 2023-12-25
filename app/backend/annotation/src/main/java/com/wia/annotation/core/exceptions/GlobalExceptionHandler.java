package com.wia.annotation.core.exceptions;

import com.wia.annotation.core.data.response.AnnotationServerErrorResponse;
import com.wia.annotation.core.exceptions.custom.AnnotationServerException;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.FieldError;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<?> exceptionHandler(NullPointerException exception) {

        log.error(exception.getMessage(), exception);

        return new ResponseEntity<>(
                new AnnotationServerErrorResponse(
                        Exceptions.GENERIC_ERROR.getId(),
                        "Something internal went wrong. Please contact the administrator.",
                        null
                ),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler(AnnotationServerException.class)
    public ResponseEntity<?> exceptionHandler(AnnotationServerException ex) {

        String userMessage;

        if (ex.getStatus() == HttpStatus.INTERNAL_SERVER_ERROR)
            userMessage = "Something internal went wrong. Please contact the administrator.";
        else
            userMessage =ex.getUserMessage();


        return new ResponseEntity<>(
                new AnnotationServerErrorResponse(
                        ex.getCode(),
                        userMessage,
                        null),
                ex.getStatus()
        );
    }

    @ExceptionHandler(MethodArgumentNotValidException.class)
    public ResponseEntity<?> processValidationError(MethodArgumentNotValidException ex) {

        List<AnnotationServerErrorResponse.Error> errors = new ArrayList<>();

        for (FieldError error : ex.getBindingResult().getFieldErrors())
            errors.add(
                    new AnnotationServerErrorResponse.Error(
                            error.getField(),
                            "error: " + error.getDefaultMessage()
                    )
            );

        for (ObjectError error : ex.getBindingResult().getGlobalErrors())
            errors.add(
                    new AnnotationServerErrorResponse.Error(
                            error.getObjectName(),
                            "error: " + error.getDefaultMessage()
                    )
            );

        return new ResponseEntity<>(
                new AnnotationServerErrorResponse(
                        Exceptions.BAD_REQUEST_PARAMETER.getId(),
                        Exceptions.BAD_REQUEST_PARAMETER.getMessage(),
                        errors
                ),
                HttpStatus.BAD_REQUEST
        );
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    public ResponseEntity<?> processRequestParameterValidationError(MissingServletRequestParameterException ex) {
        return new ResponseEntity<>(
                new AnnotationServerErrorResponse(
                        Exceptions.MISSING_REQUIRED_QUERY_PARAMETER.getId(),
                        "error: " + Exceptions.MISSING_REQUIRED_QUERY_PARAMETER.getMessage(),
                        Collections.singletonList(
                                new AnnotationServerErrorResponse.Error(
                                        ex.getParameterName(),
                                        Exceptions.MISSING_REQUIRED_QUERY_PARAMETER.getMessage()
                                )
                        )
                ),
                HttpStatus.BAD_REQUEST
        );
    }
}
