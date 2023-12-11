package com.wia.enigma.core.service.UserFollowsService;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.UserFollowsRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserFollowsServiceImpl implements UserFollowsService {

    final UserFollowsRepository userFollowsRepository;

    @Override
    public void follow(Long userId, Long followId, EntityType entityType, Boolean isAccepted) {

        if(isUserFollowsEntity(userId, followId, entityType)) {

            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION,
                    String.format("You are already following or sent follow request to %s.", entityType));
        }

        UserFollows userFollows = new UserFollows();
        userFollows.setFollowerEnigmaUserId(userId);
        userFollows.setFollowedEntityId(followId);
        userFollows.setFollowedEntityType(entityType);
        userFollows.setIsAccepted(isAccepted);
        userFollowsRepository.save(userFollows);
    }

    @Override
    public void unfollow(Long userId, Long followId, EntityType entityType) {

        userFollowsRepository.deleteByFollowerEnigmaUserIdAndFollowedEntityTypeAndFollowedEntityId(userId, entityType, followId);
    }

    @Override
    public void unfollowAll(Long entityId, EntityType entityType){

        userFollowsRepository.deleteByFollowedEntityIdAndFollowedEntityType(entityId, entityType);
    }


    public List<UserFollows> findAcceptedFollowers(Long entityId, EntityType entityType){

        return userFollowsRepository.findByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(entityId, entityType, true);
    }

    public List<UserFollows> findAcceptedFollowings(Long entityId, EntityType entityType){

        return userFollowsRepository.findByFollowerEnigmaUserIdAndFollowedEntityTypeAndIsAccepted(entityId, entityType, true);
    }

    public Long countAcceptedFollowers(Long followedId, EntityType entityType){

        return userFollowsRepository.countByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(followedId, entityType, true);
    }

    public Long countAcceptedFollowings(Long followerId, EntityType entityType){


        return userFollowsRepository.countByFollowerEnigmaUserIdAndFollowedEntityTypeAndIsAccepted(followerId, entityType, true);
    }

    public Boolean isUserFollowsEntity(Long userId, Long followId, EntityType entityType) {

        return userFollowsRepository.existsByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(userId, followId, entityType, true);
    }

    public Boolean isUserFollowsEntityOrSentRequest(Long userId, Long followId, EntityType entityType) {

        return userFollowsRepository.existsByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityType(userId, followId, entityType);
    }

    public void checkInterestAreaAccess(InterestArea interestArea, Long enigmaUserId) {
        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PERSONAL && !interestArea.getEnigmaUserId().equals(enigmaUserId)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this personal interest area:: " + interestArea.getId());
        }

        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PRIVATE && !interestArea.getEnigmaUserId().equals(enigmaUserId)
                && !isUserFollowsEntity(enigmaUserId, interestArea.getId(), EntityType.INTEREST_AREA)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this interest area:: " + interestArea.getId());
        }
    }
}