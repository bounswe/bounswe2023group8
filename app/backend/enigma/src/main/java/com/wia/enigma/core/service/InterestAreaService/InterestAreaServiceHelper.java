package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.service.InterestAreaPostService.InterestAreaPostService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.entity.NestedInterestArea;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.*;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
class InterestAreaServiceHelper {

    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;

    final InterestAreaRepository interestAreaRepository;
    final NestedInterestAreaRepository nestedInterestAreaRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostService interestAreaPostService;
    final EnigmaUserRepository enigmaUserRepository;
    final UserFollowsRepository userFollowsRepository;


    boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
    }

    InterestArea getInterestArea(Long id) {
        return interestAreaRepository.findById(id)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id));
    }

    Boolean checkInterestAreaExist(Long id) {
        return interestAreaRepository.existsById(id);
    }

    void checkAccessLevel(InterestArea interestArea, Long enigmaUserId) {
        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PERSONAL && !interestArea.getEnigmaUserId().equals(enigmaUserId)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this personal interest area:: " + interestArea.getId());
        }

        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PRIVATE && !interestArea.getEnigmaUserId().equals(enigmaUserId)
                && !userFollowsService.isUserFollowsEntity(enigmaUserId, interestArea.getId(), EntityType.INTEREST_AREA)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this interest area:: " + interestArea.getId());
        }
    }

    List<InterestArea> getNestedInterestAreas(Long id) {
        return interestAreaRepository.findAllByIdIn(
                nestedInterestAreaRepository.findAllByParentInterestAreaId(id).stream()
                        .map(NestedInterestArea::getChildInterestAreaId)
                        .collect(Collectors.toList())
        );
    }

    List<WikiTagDto> getWikiTags(Long id) {
        return wikiTagService.getWikiTags(entityTagsRepository.findAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA).stream()
                .map(EntityTag::getWikiDataTagId)
                .collect(Collectors.toList()));
    }

    void validateNestedInterestAreas(List<Long> nestedInterestAreas) {
        if (!interestAreaRepository.existsAllByIdIsIn(nestedInterestAreas)) {
            String errorMessage = "Nested interest areas not found for ids: " + nestedInterestAreas;
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, errorMessage);
        }
    }

    void validateWikiTags(List<String> wikiTags) {
        wikiTags.forEach(wikiTag -> {
            if (!isValidWikidataId(wikiTag)) {
                String errorMessage = "Invalid wiki tag id: " + wikiTag;
                throw new EnigmaException(ExceptionCodes.INVALID_WIKI_TAG_ID, errorMessage);
            }
        });
    }

    InterestArea createAndSaveInterestArea(Long enigmaUserId, String title, String description, EnigmaAccessLevel accessLevel) {
        InterestArea interestArea = InterestArea.builder()
                .enigmaUserId(enigmaUserId)
                .title(title)
                .description(description)
                .accessLevel(accessLevel)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        return interestAreaRepository.save(interestArea);
    }

    void followInterestAreaWhenCreated(Long enigmaUserId, InterestArea interestArea) {
        userFollowsRepository.save(UserFollows.builder()
                .followerEnigmaUserId(enigmaUserId)
                .followedEntityId(interestArea.getId())
                .followedEntityType(EntityType.INTEREST_AREA)
                .isAccepted(true)
                .build());
    }

    void followInterestArea(Long enigmaUserId, InterestArea interestArea) {

        userFollowsService.follow(enigmaUserId, interestArea.getId(), EntityType.INTEREST_AREA, interestArea.getAccessLevel().equals(EnigmaAccessLevel.PUBLIC));
    }

    List<EnigmaUserDto> getFollowers(Long userId, Long followedId) {
        return userFollowsService.findAcceptedFollowers(followedId, EntityType.INTEREST_AREA)
                .stream()
                .map(userFollows -> enigmaUserRepository.findEnigmaUserById(userFollows.getFollowerEnigmaUserId()))
                .map(enigmaUser -> EnigmaUserDto.builder()
                        .id(enigmaUser.getId())
                        .username(enigmaUser.getUsername())
                        .name(enigmaUser.getName())
                        .email(enigmaUser.getEmail())
                        .birthday(enigmaUser.getBirthday())
                        .createTime(enigmaUser.getCreateTime())
                        .build())
                .toList();
    }

    InterestArea updateInterestAreaDetails(Long id, String title, String description, EnigmaAccessLevel accessLevel) {
        InterestArea interestArea = interestAreaRepository.findById(id).orElseThrow(
                () -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id)
        );

        interestArea.setTitle(title);
        interestArea.setDescription(description);
        interestArea.setAccessLevel(accessLevel);

        return interestAreaRepository.save(interestArea);
    }

    void updateNestedInterestAreas(InterestArea interestArea, List<Long> nestedInterestAreas) {
        nestedInterestAreaRepository.deleteAllByParentInterestAreaId(interestArea.getId());

        List<NestedInterestArea> nestedAreas = nestedInterestAreas.stream().map(
                nestedInterestAreaId -> NestedInterestArea.builder()
                        .parentInterestAreaId(interestArea.getId())
                        .childInterestAreaId(nestedInterestAreaId)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        nestedInterestAreaRepository.saveAll(nestedAreas);
    }

    void updateWikiTags(InterestArea interestArea, List<String> wikiTags) {
        entityTagsRepository.deleteAllByEntityIdAndEntityType(interestArea.getId(), EntityType.INTEREST_AREA);

        List<EntityTag> entityTags = wikiTags.stream().map(wikiTag ->
                EntityTag.builder()
                        .entityId(interestArea.getId())
                        .entityType(EntityType.INTEREST_AREA)
                        .wikiDataTagId(wikiTag)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        entityTagsRepository.saveAll(entityTags);
    }

    void deleteRelatedEntities(Long id) {
        nestedInterestAreaRepository.deleteAllByParentInterestAreaId(id);
        entityTagsRepository.deleteAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA);
        interestAreaPostService.deleteAllByInterestAreaId(id);
        userFollowsService.unfollowAll(id, EntityType.INTEREST_AREA);
    }

    @Transactional
    public void saveEntityTags(List<String> wikiTags, InterestArea interestArea) {
        List<EntityTag> entityTags = wikiTags.stream().map(wikiTag ->
                EntityTag.builder()
                        .entityId(interestArea.getId())
                        .entityType(EntityType.INTEREST_AREA)
                        .wikiDataTagId(wikiTag)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        entityTagsRepository.saveAll(entityTags);
    }

    @Transactional
    public void saveNestedInterestAreas(List<Long> nestedInterestAreas, InterestArea interestArea) {
        List<NestedInterestArea> nestedInterestAreaList = nestedInterestAreas.stream().map(nestedInterestArea ->
                NestedInterestArea.builder()
                        .parentInterestAreaId(interestArea.getId())
                        .childInterestAreaId(nestedInterestArea)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        nestedInterestAreaRepository.saveAll(nestedInterestAreaList);
    }
}
