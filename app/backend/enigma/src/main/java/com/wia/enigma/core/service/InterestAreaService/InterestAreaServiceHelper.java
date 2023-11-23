package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.service.InterestAreaPostService.InterestAreaPostService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.*;
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
public class InterestAreaServiceHelper {

    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;

    final InterestAreaRepository interestAreaRepository;
    final NestedInterestAreaRepository nestedInterestAreaRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostService interestAreaPostService;
    final EnigmaUserRepository enigmaUserRepository;
    final UserFollowsRepository userFollowsRepository;
    private final PostRepository postRepository;
    private final WikiTagRepository wikiTagRepository;


    boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
    }

    public InterestArea getInterestArea(Long id) {
        return interestAreaRepository.findById(id)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id));
    }

    Boolean checkInterestAreaExist(Long id) {
        return interestAreaRepository.existsById(id);
    }

    void checkInterestAreaAccess(InterestArea interestArea, Long enigmaUserId) {

        userFollowsService.checkInterestAreaAccess(interestArea, enigmaUserId);
    }

    List<InterestArea> getNestedInterestAreas(Long id, Long enigmaUserId) {

        checkInterestAreaAccess(getInterestArea(id), enigmaUserId);

        return interestAreaRepository.findAllByIdIn(
                nestedInterestAreaRepository.findAllByParentInterestAreaId(id).stream()
                        .map(NestedInterestArea::getChildInterestAreaId)
                        .collect(Collectors.toList())
        );
    }



    List<WikiTag> getWikiTags(Long id) {
        return wikiTagRepository.findAllById(entityTagsRepository.findAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA).stream()
                .map(EntityTag::getWikiDataTagId)
                .collect(Collectors.toList()));
    }

    void validateNestedInterestAreas(List<Long> nestedInterestAreas, InterestArea interestArea) {


        // public private personal
        // public private personal

        List<InterestArea> nestedInterestAreaList = interestAreaRepository.findAllById(nestedInterestAreas);

        if (nestedInterestAreaList.size() != nestedInterestAreas.size()) {
            String errorMessage = "Invalid nested interest area ids: " + nestedInterestAreas;
            throw new EnigmaException(ExceptionCodes.INVALID_NESTED_INTEREST_AREA_IDS, errorMessage);
        }

        if (nestedInterestAreaList.stream().anyMatch(nestedInterestArea -> nestedInterestArea.getId().equals(interestArea.getId()))) {
            String errorMessage = "Interest area cannot be nested to itself: " + nestedInterestAreas;
            throw new EnigmaException(ExceptionCodes.INVALID_NESTED_INTEREST_AREA_IDS, errorMessage);
        }

        if (nestedInterestAreaList.stream().anyMatch(nestedInterestArea -> nestedInterestArea.getAccessLevel().equals(EnigmaAccessLevel.PRIVATE))) {
            String errorMessage = "Private interest areas cannot be nested: " + nestedInterestAreas;
            throw new EnigmaException(ExceptionCodes.INVALID_NESTED_INTEREST_AREA_IDS, errorMessage);
        }

        if(nestedInterestAreaList.stream().anyMatch(nestedInterestArea ->  nestedInterestArea.getAccessLevel().
                equals(EnigmaAccessLevel.PERSONAL) && ( !interestArea.getAccessLevel().equals(EnigmaAccessLevel.PERSONAL)
                || !nestedInterestArea.getEnigmaUserId().equals(interestArea.getEnigmaUserId() )))){
            String errorMessage = "Personal interest areas cannot be nested to other users' interest areas or non personal interest areas: " + nestedInterestAreas;
            throw new EnigmaException(ExceptionCodes.INVALID_NESTED_INTEREST_AREA_IDS, errorMessage);
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
