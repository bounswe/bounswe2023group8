package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;

public class EnigmaDatabaseException extends EnigmaRuntimeException {

    public EnigmaDatabaseException(ExceptionCodes code, String userMessage){
        super(code, HttpStatus.INTERNAL_SERVER_ERROR, userMessage);
    }
}
