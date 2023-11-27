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
@Table(name = "nested_interest_area")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NestedInterestArea {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "parent_ia_id")
    Long parentInterestAreaId;

    @Column(name = "child_ia_id")
    Long childInterestAreaId;

    @Column(name = "create_time")
    Timestamp createTime;
}