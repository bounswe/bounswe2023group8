package com.wia.annotation.core.data.request;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class AnnotationServerBaseRequest {

    @JsonProperty("@context")
    List<String> context = List.of(
            "http://www.w3.org/ns/anno.jsonld",
            "http://www.w3.org/ns/ldp.jsonld"
    );
}
