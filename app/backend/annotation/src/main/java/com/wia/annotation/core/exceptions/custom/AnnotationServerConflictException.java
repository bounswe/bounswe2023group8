package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerConflictException extends AnnotationServerException {

    public AnnotationServerConflictException(Exceptions code, String userMessage) {
        super(code, HttpStatus.CONFLICT, userMessage);
    }
}
