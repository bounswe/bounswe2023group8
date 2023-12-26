package com.wia.annotation.core.exceptions.custom;

import com.wia.annotation.core.exceptions.Exceptions;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;

@Data
@AllArgsConstructor
@NoArgsConstructor
@EqualsAndHashCode(callSuper = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnotationServerException extends RuntimeException {

    HttpStatus status;

    Integer code;

    String userMessage;

    public AnnotationServerException(Exceptions ex, HttpStatus status, String userMessage) {
        super();
        this.setStatus(status);
        this.setCode(ex.getId());
        this.setUserMessage(userMessage);
    }
}