package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;

public class EnigmaConflictException extends EnigmaRuntimeException {

    public EnigmaConflictException(ExceptionCodes code, String userMessage) {
        super(code, HttpStatus.CONFLICT, userMessage);
    }
}
