package com.wia.enigma.dal.entity;

import com.wia.enigma.dal.enums.EntityType;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "entity_tag")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EntityTag {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "entity_id")
    Long entityId;

    @Column(name = "entity_type")
    EntityType entityType;

    @Column(name="wiki_data_tag_id")
    String wikiDataTagId;

    @Column(name = "create_time")
    Timestamp createTime;
}
