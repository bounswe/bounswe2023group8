package com.wia.enigma.exceptions.custom;

import com.wia.enigma.dal.enums.ExceptionCodes;
import lombok.AccessLevel;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;

@Data
@EqualsAndHashCode(callSuper = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaRuntimeException extends RuntimeException {

    HttpStatus status;

    Integer code;

    String userMessage;

    String internalMessage;

    public EnigmaRuntimeException(ExceptionCodes ex, HttpStatus status, String internalMessage) {
        super();
        this.setStatus(status);
        this.setCode(ex.getCode());
        this.setUserMessage(ex.getMessage());
        this.setInternalMessage(internalMessage);
    }

    public EnigmaRuntimeException() {
        super();
    }
}
