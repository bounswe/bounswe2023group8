package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import jakarta.persistence.*;
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

    Long enigmaUserId;

    EnigmaAccessLevel accessLevel;

    String title;

    String description;

    List<InterestArea>  nestedInterestAreas;

    List<WikiTagDto> wikiTags;

    Timestamp createTime;
}