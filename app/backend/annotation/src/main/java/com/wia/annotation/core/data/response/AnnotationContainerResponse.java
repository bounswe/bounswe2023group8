package com.wia.annotation.core.data.response;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.wia.annotation.core.data.dto.AnnotationDto;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class AnnotationContainerResponse extends AnnotationServerBaseResponse {

    String id;

    List<String> type = List.of("BasicContainer", "AnnotationCollection");

    String label;

    First first;

    String last;

    Integer total;

    Timestamp modified;

    Timestamp created;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class First {

        String id;

        String type = "AnnotationPage";

        @JsonInclude(JsonInclude.Include.NON_NULL)
        String next;

        String partOf;

        Integer startIndex;

        List<AnnotationDto> items;

    }
}
