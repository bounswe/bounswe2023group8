package com.wia.annotation.core.data.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

import java.util.List;

@JsonPropertyOrder({"@context"})
public class AnnotationServerBaseRequest {

    @JsonProperty("@context")
    String context = "http://www.w3.org/ns/anno.jsonld";
}
