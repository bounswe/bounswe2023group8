package com.wia.enigma.exceptions;

import com.wia.enigma.core.data.response.ErrorResponse;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import com.wia.enigma.exceptions.custom.EnigmaRuntimeException;
import com.wia.enigma.utilities.ExceptionUtils;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.Date;


@Slf4j
@RestControllerAdvice
public class GlobalExceptionHandler {


    @ExceptionHandler(NullPointerException.class)
    public ResponseEntity<?> exceptionHandler(NullPointerException exception) {

        log.error(ExceptionUtils.getMessage(exception), exception);

        return new ResponseEntity<>(
                new ErrorResponse(
                        ExceptionCodes.NULL_POINTER.getCode(),
                        ExceptionCodes.NULL_POINTER.getMessage(),
                        null
                ),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler(EnigmaRuntimeException.class)
    public ResponseEntity<?> exceptionHandler(EnigmaRuntimeException ex) {

        String userMessage;

        if (ex.getStatus() == HttpStatus.INTERNAL_SERVER_ERROR) {
            log.error(ex.getInternalMessage());

            if (ex instanceof EnigmaDatabaseException)
                userMessage = ex.getInternalMessage();
            else
                userMessage = ExceptionCodes.INTERNAL_SERVER_ERROR.getMessage();

        } else
            userMessage = ex.getInternalMessage();

        return new ResponseEntity<>(new ErrorResponse(ex.getCode(), userMessage, null), null, ex.getStatus());
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<?> exceptionHandler(Exception exception) {

        log.error(ExceptionUtils.getMessage(exception), exception);

        return new ResponseEntity<>(
                new ErrorResponse(
                        ExceptionCodes.INTERNAL_SERVER_ERROR.getCode(),
                        ExceptionCodes.INTERNAL_SERVER_ERROR.getMessage(),
                        null
                ),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler(RuntimeException.class)
    public ResponseEntity<?> exceptionHandler(RuntimeException exception) {

        log.error(ExceptionUtils.getMessage(exception), exception);

        return new ResponseEntity<>(
                new ErrorResponse(
                        ExceptionCodes.INTERNAL_SERVER_ERROR.getCode(),
                        ExceptionCodes.INTERNAL_SERVER_ERROR.getMessage(),
                        null
                ),
                HttpStatus.INTERNAL_SERVER_ERROR
        );
    }

    @ExceptionHandler(UsernameNotFoundException.class)
    public ResponseEntity<?> exceptionHandler(UsernameNotFoundException exception) {

        log.error(ExceptionUtils.getMessage(exception), exception);

        return new ResponseEntity<>(
                new ErrorResponse(
                        ExceptionCodes.USER_NOT_FOUND.getCode(),
                        ExceptionCodes.USER_NOT_FOUND.getMessage(),
                        null
                ),
                HttpStatus.BAD_REQUEST
        );
    }
}