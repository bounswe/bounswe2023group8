package com.wia.enigma.dal.entity;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.data.model.InterestAreaModel;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.PostLabel;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.sql.Timestamp;
import java.util.List;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@Table(name = "post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "access_level")
    EnigmaAccessLevel accessLevel;

    @Column(name = "interest_area_id")
    Long interestAreaId;

    @Column(name = "source_link")
    String sourceLink;

    @Column(name = "title")
    String title;

    @Column(name = "label")
    PostLabel label;

    @Column(name = "content")
    String content;

    @Embedded
    GeoLocation geolocation;

    @Column(name = "create_time")
    Timestamp createTime;
    public PostDto mapToPostDto( List<WikiTag> wikiTags, EnigmaUserDto enigmaUserDto, InterestAreaModel interestAreaModel,
                                 Long upvoteCount, Long downvoteCount) {
        return PostDto.builder()
                .id(this.getId())
                .enigmaUser(enigmaUserDto)
                .interestArea(interestAreaModel)
                .sourceLink(this.getSourceLink())
                .title(this.getTitle())
                .wikiTags(wikiTags)
                .label(this.getLabel())
                .content(this.getContent())
                .upvoteCount(upvoteCount)
                .downvoteCount(downvoteCount)
                .geolocation(this.getGeolocation())
                .createTime(this.getCreateTime())
                .build();
    }

    public PostDtoSimple mapToPostDtoSimple(List<String> wikiTags) {
        return PostDtoSimple.builder()
                .id(this.getId())
                .enigmaUserId(this.getEnigmaUserId())
                .interestAreaId(this.getInterestAreaId())
                .sourceLink(this.getSourceLink())
                .title(this.getTitle())
                .wikiTags(wikiTags)
                .label(this.getLabel())
                .content(this.getContent())
                .geolocation(this.getGeolocation())
                .createTime(this.getCreateTime())
                .build();
    }
}