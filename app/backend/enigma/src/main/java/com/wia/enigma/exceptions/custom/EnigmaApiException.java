package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;

public class EnigmaApiException extends EnigmaRuntimeException{

    public EnigmaApiException(ExceptionCodes ex, String internalMessage) {
        super(ex, HttpStatus.INTERNAL_SERVER_ERROR, internalMessage);
    }
}
