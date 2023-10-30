package com.wia.enigma.dal.entity;

import com.wia.enigma.dal.enums.PostLabel;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import java.sql.Timestamp;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "ia_id")
    Long iaId;

    @Column(name = "source_link")
    String sourceLink;

    @Column(name = "geolocation")
    String geolocation;

    @Column(name = "label")
    String label; // PostLabel

    @Column(name = "create_time")
    Timestamp createTime;
}