package com.bounswe.group8.payload.response;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import jakarta.servlet.http.HttpServletRequest;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import java.time.LocalDateTime;

@Slf4j
@Getter
@Setter
@JsonInclude(JsonInclude.Include.NON_NULL)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ErrorResponse {

    Integer code;

    HttpStatus status;

    String errorId;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "dd-MM-yyyy hh:mm:ss")
    LocalDateTime timestamp;

    String message;

    Object errors;

    String debugMessage;

    String path;


    private ErrorResponse() {
        timestamp = LocalDateTime.now();
        path = getRequestPath();
    }

    public ErrorResponse(HttpStatus status, String errorId) {
        this();
        this.code = status.value();
        this.errorId = errorId;
        this.status = status;
    }

    public ErrorResponse(HttpStatus status, String errorId, String message) {
        this(status, errorId);
        this.message = message;
    }

    public ErrorResponse(HttpStatus status, String errorId, String message, Throwable ex) {
        this(status, errorId);
        this.message = message;
        this.debugMessage = ex.getLocalizedMessage();
    }

    public ErrorResponse(HttpStatus status, String errorId, Object errors) {
        this(status, errorId);
        this.errors = errors;
    }

    public ErrorResponse(HttpStatus status, String errorId, String message, Object errors) {
        this(status, errorId);
        this.message = message;
        this.errors = errors;
    }

    public static String getRequestPath(){
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        if (requestAttributes instanceof ServletRequestAttributes) {
            HttpServletRequest request = ((ServletRequestAttributes)requestAttributes).getRequest();
            return request.getRequestURI();
        }

        log.debug("Error not called in the context of an HTTP request.");
        return "";
    }

}

