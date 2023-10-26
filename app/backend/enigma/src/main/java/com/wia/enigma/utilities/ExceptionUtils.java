package com.wia.enigma.utilities;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.http.HttpStatus;

import java.io.IOException;
import java.io.PrintWriter;

public class ExceptionUtils {

    public static String getMessage(Exception exception) {

        String message = null;
        if (exception != null) {
            if (exception.getMessage() == null) {
                if (exception.getCause() != null)
                    message = exception.getCause().getMessage();
            } else
                message = exception.getMessage();
        }

        return message;
    }
}
