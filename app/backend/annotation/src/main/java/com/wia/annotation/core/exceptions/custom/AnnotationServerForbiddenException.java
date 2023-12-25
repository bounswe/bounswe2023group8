package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerForbiddenException extends AnnotationServerException {

    public AnnotationServerForbiddenException(Exceptions code, String userMessage) {
        super(code, HttpStatus.FORBIDDEN, userMessage);
    }
}
