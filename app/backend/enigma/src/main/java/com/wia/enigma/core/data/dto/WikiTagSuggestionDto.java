package com.wia.enigma.core.data.dto;

import jakarta.persistence.Column;
import jakarta.persistence.Id;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class WikiTagSuggestionDto {

    @Id
    @Column(name = "id")
    Long id;

    @Column(name = "wiki_data_tag_id")
    String wikiDataTagId;

    @Column(name = "label")
    String label;

    @Column(name = "description")
    String description;

    @Column(name = "is_valid_tag")
    Boolean isValidTag;

    @Column(name = "requester_count")
    Long requesterCount;

}
