package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserFollowsRepository extends JpaRepository<UserFollows, Long> {

    long countByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(Long followedEntityId, EntityType followedEntityType, Boolean isAccepted);

    void deleteByFollowedEntityIdAndFollowedEntityType(Long followedEntityId, EntityType followedEntityType);

    boolean existsByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(Long followerEnigmaUserId, Long followedEntityId, EntityType followedEntityType, Boolean isAccepted);

    List<UserFollows> findByFollowerEnigmaUserIdAndFollowedEntityTypeAndIsAccepted(Long followerEnigmaUserId, EntityType followedEntityType, Boolean isAccepted);

    List<UserFollows> findByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(Long followedEntityId, EntityType followedEntityType, Boolean isAccepted);

    void deleteByFollowerEnigmaUserIdAndFollowedEntityTypeAndFollowedEntityId(Long enigmaUserId, EntityType followedEntityType, Long followedEntityId);

    List<UserFollows> findAllByFollowerEnigmaUserId(Long enigmaUserId);

    List<UserFollows> findAllByFollowedEntityIdAndFollowedEntityType(Long followedEntityId, EntityType followedEntityType);
}