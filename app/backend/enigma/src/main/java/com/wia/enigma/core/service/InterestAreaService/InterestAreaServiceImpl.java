package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
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
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaServiceImpl implements InterestAreaService {

    final InterestAreaRepository interestAreaRepository;
    final NestedInterestAreaRepository nestedInterestAreaRepository;
    final EntityTagsRepository entityTagsRepository;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;
    final InterestAreaPostService interestAreaPostService;
    final EnigmaUserRepository enigmaUserRepository;

    @Override
    @Transactional(readOnly = true)
    public InterestAreaDto getInterestArea(Long id, Long enigmaUserId) {
        InterestArea interestArea = interestAreaRepository.findById(id)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id));

        checkAccessLevel(interestArea, enigmaUserId);

        List<InterestArea> nestedInterestAreas = getNestedInterestAreas(id);
        List<WikiTagDto> wikiTags = getWikiTags(id);

        return mapToInterestAreaDto(interestArea, nestedInterestAreas, wikiTags);
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String title, String description,
                                                    EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas,
                                                    List<String> wikiTags) {

        validateNestedInterestAreas(nestedInterestAreas);
        validateWikiTags(wikiTags);

        InterestArea interestArea = createAndSaveInterestArea(enigmaUserId, title, description, accessLevel);

        saveNestedInterestAreas(nestedInterestAreas, interestArea);
        saveEntityTags(wikiTags, interestArea);
        followInterestArea(enigmaUserId, interestArea);

        return mapToInterestAreaSimpleDto(interestArea, nestedInterestAreas, wikiTags);
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto updateInterestArea(Long id, String title, String description,
                                                    EnigmaAccessLevel accessLevel,
                                                    List<Long> nestedInterestAreas,
                                                    List<String> wikiTags) {

        validateNestedInterestAreas(nestedInterestAreas);
        validateWikiTags(wikiTags);

        InterestArea interestArea = updateInterestAreaDetails(id, title, description, accessLevel);

        updateNestedInterestAreas(interestArea, nestedInterestAreas);
        updateWikiTags(interestArea, wikiTags);

        return mapToInterestAreaSimpleDto(interestArea, nestedInterestAreas, wikiTags);
    }

    @Override
    @Transactional
    public void deleteInterestArea(Long id) {
        if(!interestAreaRepository.existsById(id)){
            log.error("Interest area not found for id: {}", id);
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id);
        }

        interestAreaRepository.deleteById(id);

        nestedInterestAreaRepository.deleteAllByParentInterestAreaId(id);
        entityTagsRepository.deleteAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA);
        interestAreaPostService.deleteAllByInterestAreaId(id);
        userFollowsService.unfollowAll(id, EntityType.INTEREST_AREA);
    }

    @Override
    @Transactional
    public void followInterestArea(Long enigmaUserId, Long interestAreaId){

        InterestArea interestArea = interestAreaRepository.findInterestAreaById(interestAreaId);

        if(interestArea == null){
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: "
                    + interestAreaId);
        }

        if(userFollowsService.isUserFollowsEntityOrSentRequest(enigmaUserId, interestAreaId, EntityType.INTEREST_AREA)) {

            throw new EnigmaException(ExceptionCodes.INVALID_REQUEST, "You already follow  or sent follow request to this interest area: " + interestAreaId);
        }

        UserFollows userFollow = UserFollows.builder()
                .followerEnigmaUserId(enigmaUserId)
                .followedEntityId(interestAreaId)
                .followedEntityType(EntityType.INTEREST_AREA)
                .isAccepted(interestArea.getAccessLevel().equals(interestArea.getAccessLevel().PUBLIC))
                .build();

        userFollowsService.follow(userFollow);
    }

    @Override
    @Transactional
    public void unfollowInterestArea(Long enigmaUserId, Long interestAreaId){

        InterestArea interestArea = interestAreaRepository.findInterestAreaById(interestAreaId);

        if(interestArea == null){
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + interestAreaId);
        }

        userFollowsService.unfollow(enigmaUserId, interestAreaId, EntityType.INTEREST_AREA);
    }

    @Override
    public List<EnigmaUserDto> getFollowers(Long userId, Long followedId){

        InterestArea interestArea = interestAreaRepository.findById(followedId)
                .orElseThrow(() -> new IllegalArgumentException("Interest area not found"));

        if(!interestArea.getAccessLevel().equals(EnigmaAccessLevel.PRIVATE)){

            if(!userId.equals(interestArea.getEnigmaUserId())){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "You cannot get followers of this interest area type:" + EntityType.INTEREST_AREA);
            }
        }

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

    @Override
    public List<InterestAreaSimpleDto>  search(Long userId, String searchKey){


        List<String> relatedWikiTags = wikiTagService.searchWikiTags(searchKey).stream().map(
                searchResult ->(String) searchResult.get("id")
        ).toList();

        List<Long> relatedInterestAreaIds =  entityTagsRepository.findByWikiDataTagIdInAndEntityType(relatedWikiTags, EntityType.INTEREST_AREA)
                .stream()
                .map(entityTag -> entityTag.getEntityId()).toList();

        return interestAreaRepository.findByAccessLevelNotAndTitleContainsOrIdIn(EnigmaAccessLevel.PERSONAL, searchKey, relatedInterestAreaIds).stream()
                .map(interestArea -> InterestAreaSimpleDto.builder()
                        .id(interestArea.getId())
                        .enigmaUserId(interestArea.getEnigmaUserId())
                        .title(interestArea.getTitle())
                        .accessLevel(interestArea.getAccessLevel())
                        .createTime(interestArea.getCreateTime())
                        .build()
                ).toList();
    }

    @Override
    public Boolean isInterestAreaExist(Long id) {
        return interestAreaRepository.existsById(id);
    }

    private boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
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

    private void checkAccessLevel(InterestArea interestArea, Long enigmaUserId) {
        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PERSONAL && !interestArea.getEnigmaUserId().equals(enigmaUserId)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this personal interest area:: " + interestArea.getId());
        }

        if (interestArea.getAccessLevel() == EnigmaAccessLevel.PRIVATE && !interestArea.getEnigmaUserId().equals(enigmaUserId)
                && !userFollowsService.isUserFollowsEntity(enigmaUserId, interestArea.getId(), EntityType.INTEREST_AREA)) {
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this private interest area:: " + interestArea.getId());
        }
    }

    private List<InterestArea> getNestedInterestAreas(Long id) {
        return interestAreaRepository.findAllByIdIn(
                nestedInterestAreaRepository.findAllByParentInterestAreaId(id).stream()
                        .map(NestedInterestArea::getChildInterestAreaId)
                        .collect(Collectors.toList())
        );
    }

    private List<WikiTagDto> getWikiTags(Long id) {
        return wikiTagService.getWikiTags(entityTagsRepository.findAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA).stream()
                .map(EntityTag::getWikiDataTagId)
                .collect(Collectors.toList()));
    }

    private InterestAreaDto mapToInterestAreaDto(InterestArea interestArea, List<InterestArea> nestedInterestAreas, List<WikiTagDto> wikiTags) {
        return InterestAreaDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .title(interestArea.getTitle())
                .description(interestArea.getDescription())
                .accessLevel(interestArea.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.getCreateTime())
                .build();
    }

    private void validateNestedInterestAreas(List<Long> nestedInterestAreas) {
        if (!interestAreaRepository.existsAllByIdIsIn(nestedInterestAreas)) {
            String errorMessage = "Nested interest areas not found for ids: " + nestedInterestAreas;
            log.error(errorMessage);
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, errorMessage);
        }
    }

    private void validateWikiTags(List<String> wikiTags) {
        wikiTags.forEach(wikiTag -> {
            if (!isValidWikidataId(wikiTag)) {
                String errorMessage = "Invalid wiki tag id: " + wikiTag;
                log.error(errorMessage);
                throw new EnigmaException(ExceptionCodes.INVALID_WIKI_TAG_ID, errorMessage);
            }
        });
    }

    private InterestArea createAndSaveInterestArea(Long enigmaUserId, String title, String description, EnigmaAccessLevel accessLevel) {
        InterestArea interestArea = InterestArea.builder()
                .enigmaUserId(enigmaUserId)
                .title(title)
                .description(description)
                .accessLevel(accessLevel)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        return interestAreaRepository.save(interestArea);
    }

    private void followInterestArea(Long enigmaUserId, InterestArea interestArea) {
        userFollowsService.follow(UserFollows.builder()
                .followerEnigmaUserId(enigmaUserId)
                .followedEntityId(interestArea.getId())
                .followedEntityType(EntityType.INTEREST_AREA)
                .isAccepted(true)
                .build());
    }

    private InterestAreaSimpleDto mapToInterestAreaSimpleDto(InterestArea interestArea, List<Long> nestedInterestAreas, List<String> wikiTags) {
        return InterestAreaSimpleDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .title(interestArea.getTitle())
                .description(interestArea.getDescription())
                .accessLevel(interestArea.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.getCreateTime())
                .build();
    }

    private InterestArea updateInterestAreaDetails(Long id, String title, String description, EnigmaAccessLevel accessLevel) {
        InterestArea interestArea = interestAreaRepository.findById(id).orElseThrow(
                () -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id)
        );

        interestArea.setTitle(title);
        interestArea.setDescription(description);
        interestArea.setAccessLevel(accessLevel);

        return interestAreaRepository.save(interestArea);
    }

    private void updateNestedInterestAreas(InterestArea interestArea, List<Long> nestedInterestAreas) {
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

    private void updateWikiTags(InterestArea interestArea, List<String> wikiTags) {
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
}
