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
@Table(name = "post-vote")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostVote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "post_id")
    Long postId;

    @Column(name = "vote")
    Boolean vote;

    @Column(name = "create_time")
    Timestamp createTime;

}
