package com.wia.enigma.core.data.request;

import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class VoteRequest {

    @NotNull
    Long votedEnigmaUserId;

    @NotNull
    Integer vote;

    String comment;
}
