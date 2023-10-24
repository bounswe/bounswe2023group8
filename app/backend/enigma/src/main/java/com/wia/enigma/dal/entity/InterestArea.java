package com.wia.enigma.dal.entity;


import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;

import java.sql.Timestamp;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "interest_area")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestArea {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "access_level")
    String accessLevel; // EnigmaAccessLevel

    @Column(name = "name")
    String name;

    @Column(name = "create_time")
    Timestamp createTime;
}