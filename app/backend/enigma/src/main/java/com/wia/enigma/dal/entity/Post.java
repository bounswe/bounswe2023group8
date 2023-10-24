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

    @Id
    @Column(name = "user_id")
    Long userId;

    @Id
    @Column(name = "ia_id")
    Long iaId;

    @Column(name = "source_link")
    String sourceLink;

    @Column(name = "geolocation")
    String geolocation;

    @Column(name = "label")
    PostLabel label;

    @Column(name = "create_time")
    Timestamp createTime;
}