package com.wia.enigma.core.data.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
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
public class ReputationVoteDto {

    Long enigmaUserId;

    Integer voteSum;

    Integer voteCount;

    Double voteAverage;

    List<Vote> votes;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class Vote {

        Long voterEnigmaUserId;

        String voteType;

        @JsonInclude(JsonInclude.Include.NON_NULL)
        Long votedEnigmaUserId;

        @JsonInclude(JsonInclude.Include.NON_NULL)
        Long postId;

        Integer vote;

        String comment;

        Timestamp createTime;
    }
}
