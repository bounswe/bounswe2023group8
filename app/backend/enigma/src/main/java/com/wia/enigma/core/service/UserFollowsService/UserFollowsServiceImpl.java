package com.wia.enigma.core.service.UserFollowsService;

import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.repository.UserFollowsRepository;
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
    public void follow(UserFollows userFollows) {

        userFollowsRepository.save(userFollows);
    }

    @Override
    public void unfollow(Long userId, Long followId, EntityType entityType) {

        userFollowsRepository.deleteByFollowerEnigmaUserIdAndFollowedEntityTypeAndFollowedEntityId(userId, entityType, followId);
    }

    public List<UserFollows> findAcceptedFollowers(Long entityId, EntityType entityType){

        return userFollowsRepository.findByFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(entityId, entityType, true);
    }

    public List<UserFollows> findAcceptedFollowings(Long entityId, EntityType entityType){

        return userFollowsRepository.findByFollowerEnigmaUserIdAndFollowedEntityTypeAndIsAccepted(entityId, entityType, true);
    }

    public Boolean isUserFollowsEntity(Long userId, Long followId, EntityType entityType) {

        return userFollowsRepository.existsByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityTypeAndIsAccepted(userId, followId, entityType, true);
    }

    public Boolean isUserFollowsEntityOrSentRequest(Long userId, Long followId, EntityType entityType) {

        return userFollowsRepository.existsByFollowerEnigmaUserIdAndFollowedEntityIdAndFollowedEntityType(userId, followId, entityType);
    }
}