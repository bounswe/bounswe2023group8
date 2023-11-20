package com.wia.enigma.core.service.UserFollowsService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EntityType;

import java.util.List;
import java.util.Optional;

public interface UserFollowsService {

    void follow(UserFollows userFollows);

    void unfollow(Long userId, Long followId, EntityType entityType);

    List<UserFollows> findAcceptedFollowers(Long followedId, EntityType entityType);
    List<UserFollows> findAcceptedFollowings(Long followerId, EntityType entityType);

    Optional<UserFollows> findUserFollowsEntity(Long userId, Long followId, EntityType entityType);
}
