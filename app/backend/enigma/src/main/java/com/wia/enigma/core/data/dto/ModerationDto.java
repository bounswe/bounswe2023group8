package com.wia.enigma.core.data.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ModerationDto {

    Long fromEnigmaUserId;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Long toEnigmaUserId;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Long postId;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    Long interestAreaId;

    String moderationType;

    @JsonInclude(JsonInclude.Include.NON_NULL)
    String reason;
}
