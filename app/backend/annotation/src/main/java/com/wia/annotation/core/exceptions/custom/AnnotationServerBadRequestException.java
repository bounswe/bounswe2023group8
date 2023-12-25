package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerBadRequestException extends AnnotationServerException {

    public AnnotationServerBadRequestException(Exceptions code, String userMessage) {
        super(code, HttpStatus.BAD_REQUEST, userMessage);
    }
}
