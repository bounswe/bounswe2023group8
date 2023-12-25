package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerInternalException extends AnnotationServerException {

    public AnnotationServerInternalException(Exceptions code, String userMessage) {
        super(code, HttpStatus.INTERNAL_SERVER_ERROR, userMessage);
    }
}
