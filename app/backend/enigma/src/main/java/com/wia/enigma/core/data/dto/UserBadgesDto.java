package com.wia.enigma.core.data.dto;

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
public class UserBadgesDto {

    Long enigmaUserId;

    Integer postCount;

    Integer voteSum;

    Double reputationRatio;

    String reputation;

    List<Badge> badges;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class Badge {

        String badgeName;

        String badgeDescription;

    }

}
