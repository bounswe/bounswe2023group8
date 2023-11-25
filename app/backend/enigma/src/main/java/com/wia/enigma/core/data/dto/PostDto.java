package com.wia.enigma.core.data.dto;

import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.PostLabel;
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
public class PostDto {

    Long id;
    EnigmaUserDto enigmaUser;
    Long interestAreaId;
    String sourceLink;
    String title;
    List<WikiTag> wikiTags;
    PostLabel label;
    String content;
    GeoLocation geolocation;
    Timestamp createTime;
}