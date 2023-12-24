package com.wia.annotation.core.data.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class CreateAnnotationContainerRequest {

    @JsonProperty("@context")
    List<String> context = List.of(
            "http://www.w3.org/ns/anno.jsonld",
            "http://www.w3.org/ns/ldp.jsonld");

    List<String> type;

    String label;

    String name;
}
