package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
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
public class InterestAreaSimpleDto {

    Long id;

    Long enigmaUserId;

    EnigmaAccessLevel accessLevel;

    String name;

    List<Long> nestedInterestAreas;

    List<String> wikiTags;

    Timestamp createTime;
}