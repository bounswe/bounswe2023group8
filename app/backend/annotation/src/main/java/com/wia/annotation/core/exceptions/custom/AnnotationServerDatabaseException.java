package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerDatabaseException extends AnnotationServerException {

    public AnnotationServerDatabaseException(Exceptions code, String userMessage) {
        super(code, HttpStatus.INTERNAL_SERVER_ERROR, userMessage);
    }
}
