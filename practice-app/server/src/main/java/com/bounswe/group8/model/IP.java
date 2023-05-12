package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "ip", uniqueConstraints = {
        @UniqueConstraint(name = "UniqueIPPerIP", columnNames = { "ip", "city", "country" }) })
@Data
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class IP {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "ip", nullable = false)
    String ip;

    @Column(name = "city", nullable = false)
    String city;

    @Column(name = "country", nullable = false)
    String country;
}