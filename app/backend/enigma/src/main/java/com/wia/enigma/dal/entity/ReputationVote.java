package com.wia.enigma.dal.entity;

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
@Table(name = "reputation_votes")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReputationVote {


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "voter_enigma_user_id")
    Long voterEnigmaUserId;

    @Column(name = "voted_enigma_user_id")
    Long votedEnigmaUserId;

    @Column(name = "post_id")
    Long postId;

    @Column(name = "vote")
    Integer vote;

    @Column(name = "comment")
    String comment;

    @Column(name = "create_time")
    Timestamp createTime;
}