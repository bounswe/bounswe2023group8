package com.wia.annotation.core.data.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class AnnotationDto {

    String id;

    String type = "Annotation";

    Body body;

    String target;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class Body {

        String type = "TextualBody";

        String value;
    }
}
