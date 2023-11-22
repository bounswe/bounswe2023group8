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
    EnigmaAccessLevel accessLevel;

    @Column(name = "title")
    String title;

    @Column(name = "description")
    String description;

    @Column(name = "create_time")
    Timestamp createTime;
}