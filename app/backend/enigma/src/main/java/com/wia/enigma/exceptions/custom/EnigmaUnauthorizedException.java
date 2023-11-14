package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;

public class EnigmaUnauthorizedException extends EnigmaRuntimeException {

    public EnigmaUnauthorizedException(ExceptionCodes ex, String internalMessage) {
        super(ex, HttpStatus.UNAUTHORIZED, internalMessage);
    }
}
