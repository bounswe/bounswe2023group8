package com.wia.enigma.dal.entity;


import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.sql.Timestamp;
import java.util.List;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "interest_area")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestArea {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "access_level")
    EnigmaAccessLevel accessLevel;

    @Column(name = "title")
    String title;

    @Column(name = "description")
    String description;

    @Column(name = "create_time")
    Timestamp createTime;

    public InterestAreaSimpleDto mapToInterestAreaSimpleDto( List<Long> nestedInterestAreas, List<String> wikiTags) {
        return InterestAreaSimpleDto.builder()
                .id(this.getId())
                .enigmaUserId(this.getEnigmaUserId())
                .title(this.getTitle())
                .description(this.getDescription())
                .accessLevel(this.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(this.getCreateTime())
                .build();
    }

    public InterestAreaDto mapToInterestAreaDto(List<WikiTag> wikiTags) {
        return InterestAreaDto.builder()
                .id(this.getId())
                .title(this.getTitle())
                .description(this.getDescription())
                .accessLevel(this.getAccessLevel())
                .wikiTags(wikiTags)
                .createTime(this.getCreateTime())
                .build();
    }
}