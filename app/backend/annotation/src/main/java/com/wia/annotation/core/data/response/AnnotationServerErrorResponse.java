package com.wia.annotation.core.data.response;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class AnnotationServerErrorResponse {

    Integer code;

    String message;

    List<Error> errors;

    @Data
    @AllArgsConstructor
    public static class Error {
        String field;
        String message;
    }
}
