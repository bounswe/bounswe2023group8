package com.wia.enigma.dal.entity;

import com.wia.enigma.dal.enums.EnigmaAccessLevel;
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
@Table(name = "interest_area_post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaPost {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "interest_area_id")
    Long interestAreaId;

    @Column(name = "post_id")
    Long postId;

    @Column(name = "create_time")
    Timestamp createTime;
}

