package com.wia.enigma.exceptions.custom;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class ApiError {
    private int errorCode;
    private String message;

    public ApiError(int errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }
}