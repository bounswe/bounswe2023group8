package com.wia.enigma.dal.entity;

import com.wia.enigma.core.data.model.GeoLocation;
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
@Builder
@Table(name = "post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Post {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "interest_area_id")
    Long interestAreaId;

    @Column(name = "source_link")
    String sourceLink;

    @Column(name = "title")
    String title;

    @Column(name = "label")
    PostLabel label;

    @Embedded
    GeoLocation geolocation;

    @Column(name = "create_time")
    Timestamp createTime;
}