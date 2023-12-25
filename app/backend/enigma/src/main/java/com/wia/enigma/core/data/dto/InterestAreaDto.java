package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.util.List;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class InterestAreaDto {

    Long id;

    Long creatorId;

    EnigmaAccessLevel accessLevel;

    String title;

    String description;

    List<WikiTag> wikiTags;

    String pictureUrl;

    Timestamp createTime;
}