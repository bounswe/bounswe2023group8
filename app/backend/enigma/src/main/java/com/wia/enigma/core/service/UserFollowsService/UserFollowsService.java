package com.wia.enigma.core.service.UserFollowsService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EntityType;

import java.util.List;
import java.util.Optional;

public interface UserFollowsService {

    void follow(Long userId, Long followId, EntityType entityType, Boolean isAccepted);

    void unfollow(Long userId, Long followId, EntityType entityType);

    void unfollowAll(Long userId, EntityType entityType);

    void acceptFollowRequest(UserFollows userFollows);

    void rejectFollowRequest(UserFollows userFollows);

    List<UserFollows> findFollowers(Long followedId, EntityType entityType, Boolean isAccepted);

    Long countAcceptedFollowers(Long followedId, EntityType entityType);

    List<UserFollows> findFollowings(Long followerId, EntityType entityType, Boolean isAccepted);

    Boolean isUserFollowsEntity(Long userId, Long followId, EntityType entityType);

    void checkInterestAreaAccess(InterestArea interestArea, Long enigmaUserId);

    void checkInterestAreaBasicDataAccess(InterestArea interestArea, Long enigmaUserId);

    void deleteAllForUser(Long enigmaUserId);
}
