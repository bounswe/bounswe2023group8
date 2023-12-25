package com.wia.enigma.dal.entity;

import com.wia.enigma.dal.enums.EntityType;
import jakarta.persistence.*;
import lombok.*;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@Table(name = "tag_suggestion")
public class TagSuggestion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "entity_type")
    EntityType entityType;

    @Column(name = "entity_id")
    Long entityId;

    @Column(name="wiki_data_tag_id")
    String wikiDataTagId;

    @Column(name= "requester_count")
    Long requesterCount;
}
