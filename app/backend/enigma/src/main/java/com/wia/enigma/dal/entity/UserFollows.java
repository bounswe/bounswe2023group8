package com.wia.enigma.dal.entity;

import com.wia.enigma.dal.enums.EntityType;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@Table(name = "user_follows")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserFollows {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "follower_enigma_user_id")
    Long followerEnigmaUserId;

    @Column(name = "followed_entity_id")
    Long followedEntityId;

    @Column(name = "followed_entity_type")
    EntityType followedEntityType;

    @Column(name = "is_accepted")
    Boolean isAccepted;
}