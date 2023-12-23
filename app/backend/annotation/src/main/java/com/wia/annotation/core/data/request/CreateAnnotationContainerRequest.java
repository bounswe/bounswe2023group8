package com.wia.annotation.core.data.request;

import lombok.Data;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class CreateAnnotationContainerRequest extends AnnotationServerBaseRequest {

    List<String> type;
    String label;
}
