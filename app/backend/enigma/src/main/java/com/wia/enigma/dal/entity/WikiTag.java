package com.wia.enigma.dal.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@Table(name = "wiki_tag")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WikiTag {

    @Id
    @Column(name = "id")
    String id;

    @Column(name = "label")
    String label;

    @Column(name = "description")
    String description;

    @Column(name = "is_valid_tag")
    Boolean isValidTag;
}
