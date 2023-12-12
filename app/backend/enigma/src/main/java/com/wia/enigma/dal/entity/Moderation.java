package com.wia.enigma.dal.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

@Data
@Entity
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "moderation")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Moderation {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "from_enigma_user_id")
    Long fromEnigmaUserId;

    @Column(name = "to_enigma_user_id")
    Long toEnigmaUserId;

    @Column(name = "post_id")
    Long postId;

    @Column(name = "interest_area_id")
    Long interestAreaId;

    @Column(name = "moderation_type")
    String moderationType;

    @Column(name = "reason")
    String reason;
}
