package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;


@Entity
@Table(name = "wiki")
@Data
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class Wiki {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "label", nullable = false)
    String label;

    @Column(name = "code", nullable = false)
    String code;


}
