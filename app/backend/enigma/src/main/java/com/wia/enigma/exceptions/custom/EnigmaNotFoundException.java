package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ResponseStatus;

public class EnigmaNotFoundException extends EnigmaRuntimeException {

    public EnigmaNotFoundException(ExceptionCodes code, String userMessage){
        super(code, HttpStatus.NOT_FOUND, userMessage);
    }
}
