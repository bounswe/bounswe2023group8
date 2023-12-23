package com.wia.annotation.core.data.request;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class CreateAnnotationRequest extends  AnnotationServerBaseRequest {

    String type = "Annotation";

    Body body;

    String target;

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class Body {

        String type = "TextualBody";

        String value;

        String name;
    }
}
