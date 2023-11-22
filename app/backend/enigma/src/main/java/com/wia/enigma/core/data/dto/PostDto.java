package com.wia.enigma.core.data.dto;

import com.wia.enigma.core.data.model.GeoLocation;
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
    Long enigmaUserId;
    Long interestAreaId;
    String sourceLink;
    String title;
    List<WikiTagDto> wikiTags;
    PostLabel label;
    GeoLocation geolocation;
    Timestamp createTime;
}
