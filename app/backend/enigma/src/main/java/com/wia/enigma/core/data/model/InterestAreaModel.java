package com.wia.enigma.core.data.model;

import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import jakarta.persistence.Column;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class InterestAreaModel {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "access_level")
    EnigmaAccessLevel accessLevel;

    @Column(name = "title")
    String title;

    @Column(name = "description")
    String description;

    @Column(name = "create_time")
    Timestamp createTime;

}
