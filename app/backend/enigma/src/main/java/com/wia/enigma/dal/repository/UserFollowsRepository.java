package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;
import java.util.Optional;

public interface UserFollowsRepository extends JpaRepository<UserFollows, Long> {
    List<UserFollows> findByFollowerEnigmaUserIdAndFollowedEntityTypeAndIsAccepted(Long followerEnigmaUserId, EntityType followedEntityType, Boolean isAccepted);
    List<UserFollows> findByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(Long followedEntityId, EntityType followedEntityType, Boolean isAccepted);
    Optional<UserFollows> findByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityType(Long enigmaUserId, Long followedEntityId, EntityType followedEntityType);
    void deleteByFollowerEnigmaUserIdAndFollowedEntityTypeAndFollowedEntityId(Long enigmaUserId, EntityType followedEntityType, Long followedEntityId);
}