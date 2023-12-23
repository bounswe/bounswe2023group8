package com.wia.annotation.core.data.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.util.List;

@JsonPropertyOrder({"@context"})
public class AnnotationServerBaseResponse {

    @JsonProperty("@context")
    List<String> context = List.of(
            "http://www.w3.org/ns/anno.jsonld",
            "http://www.w3.org/ns/ldp.jsonld"
    );
}
