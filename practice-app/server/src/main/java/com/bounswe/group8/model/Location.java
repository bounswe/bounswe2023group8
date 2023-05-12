package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Entity
@Table(
        name = "location",
        uniqueConstraints = {
                @UniqueConstraint(name = "UniqueLocationsPerTitle", columnNames = { "latitude", "longitude", "address", "title" })})
@Data
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Location {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "latitude", nullable = false)
    double latitude;

    @Column(name = "longitude", nullable = false)
    double longitude;

    @Column(name = "address", nullable = false)
    String address;

    @Column(name = "title", nullable = false)
    String title;


}
