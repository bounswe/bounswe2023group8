package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import org.springframework.http.HttpStatus;

public class AnnotationServerNotFoundException extends AnnotationServerException {

    public AnnotationServerNotFoundException(Exceptions code, String userMessage) {
        super(code, HttpStatus.NOT_FOUND, userMessage);
    }
}
