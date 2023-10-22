package com.wia.enigma.exceptions;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
class ErrorDetails {
    Integer status;
    String message;
    Date timestamp;
}