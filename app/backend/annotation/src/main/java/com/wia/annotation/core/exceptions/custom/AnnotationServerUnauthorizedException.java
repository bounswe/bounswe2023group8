package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerUnauthorizedException extends AnnotationServerException {

    public AnnotationServerUnauthorizedException(Exceptions code, String userMessage) {
        super(code, HttpStatus.UNAUTHORIZED, userMessage);
    }
}
