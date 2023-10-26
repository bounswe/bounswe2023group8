package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;

public class EnigmaBadRequestException extends EnigmaRuntimeException {

    public EnigmaBadRequestException(ExceptionCodes code, String userMessage) {
        super(code, HttpStatus.BAD_REQUEST, userMessage);
    }
}
