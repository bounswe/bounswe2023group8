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

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "creator_user_id")
    Long creatorUserId;

    @Column(name = "access_level")
    EnigmaAccessLevel accessLevel;

    @Column(name = "name")
    String name;

    @Column(name = "create_time")
    Timestamp createTime;
}