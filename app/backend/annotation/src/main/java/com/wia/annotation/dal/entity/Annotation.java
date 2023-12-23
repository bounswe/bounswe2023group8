package com.wia.annotation.dal.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Getter
@Setter
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "annotation")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Annotation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "container_name")
    String containerName;

    @Column(name = "annotation_name")
    String annotationName;

    @Column(name = "type")
    String type;

    @Column(name = "label")
    String value;

    @Column(name = "target")
    String target;

    @Column(name = "modified")
    Timestamp modified;

    @Column(name = "created")
    Timestamp created;
}
