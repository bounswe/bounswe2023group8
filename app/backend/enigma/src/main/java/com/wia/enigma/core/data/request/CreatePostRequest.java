package com.wia.enigma.core.data.request;

import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.dal.enums.PostLabel;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreatePostRequest {

    @NotNull
    Long interestAreaId;

    @NotNull
    String sourceLink;

    @NotNull
    String title;

    @NotNull
    List<String> wikiTags;

    @NotNull
    PostLabel label;

    @NotNull
    String content;

    @NotNull
    Boolean isAgeRestricted;

    @NotNull
    GeoLocation geoLocation;

}
