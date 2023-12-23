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
@Table(name = "annotation_container")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnotationContainer {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "container_name")
    String containerName;

    @Column(name = "label")
    String label;

    @Column(name = "modified")
    Timestamp modified;
}