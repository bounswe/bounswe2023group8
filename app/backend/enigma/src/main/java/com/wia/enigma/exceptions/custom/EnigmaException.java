package com.wia.enigma.exceptions.custom;
import com.wia.enigma.dal.enums.ExceptionCodes;

public class EnigmaException extends RuntimeException {

    private final ExceptionCodes exceptionCode;

    public EnigmaException(ExceptionCodes exceptionCode) {
        super(exceptionCode.getMessage());
        this.exceptionCode = exceptionCode;
    }

    public EnigmaException(ExceptionCodes exceptionCode, String additionalMessage) {
        super(exceptionCode.getMessage() + ": " + additionalMessage);
        this.exceptionCode = exceptionCode;
    }

    public EnigmaException(ExceptionCodes exceptionCode, Throwable cause) {
        super(exceptionCode.getMessage(), cause);
        this.exceptionCode = exceptionCode;
    }

    public ExceptionCodes getExceptionCode() {
        return exceptionCode;
    }
}

