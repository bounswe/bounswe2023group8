package com.wia.enigma.dal.entity;

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
@Table(name = "post-comment")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostComment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "post_id")
    Long postId;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "content")
    String content;

    @Column(name = "create_time")
    Timestamp createTime;
}
