package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.*;
import com.wia.enigma.exceptions.custom.EnigmaNotFoundException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;
import java.util.Optional;

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
    final EnigmaUserRepository enigmaUserRepository;

    @Override
    @Transactional(readOnly = true)
    public InterestAreaDto getInterestArea(Long id, Long enigmaUserId) {


        Optional<InterestArea> interestArea;

        try{
            interestArea =  interestAreaRepository.findById(id);
        }catch(Exception e){
            log.error("Error while fetching interest area for id: {}", id);
            throw new RuntimeException("Error while fetching interest area for id: " + id);
        }

        if(!interestArea.isPresent()){
            log.error("Interest area not found for id: {}", id);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id);
        }

        if(interestArea.get().getAccessLevel() == EnigmaAccessLevel.PERSONAL && !interestArea.get().getEnigmaUserId().equals(enigmaUserId)){
            log.error("You don't have access to this personal interest area: {}", id);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this personal interest area:: " + id);
        }

        if(interestArea.get().getAccessLevel() == EnigmaAccessLevel.PRIVATE ){

            if(!interestArea.get().getEnigmaUserId().equals(enigmaUserId)){

                if(!userFollowsService.findUserFollowsEntity(enigmaUserId, interestArea.get().getId(), EntityType.INTEREST_AREA ).get().getIsAccepted() ){

                    log.error("You don't have access to this private interest area: {}", id);
                    throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "You don't have access to this private interest area:: " + id);
                }
            }
        }

        List<InterestArea> nestedInterestAreas;

        try{
             nestedInterestAreas = interestAreaRepository.findAllByIdIn(
                nestedInterestAreaRepository.findAllByParentInterestAreaId(id).stream().map(
                        nestedInterestArea -> nestedInterestArea.getChildInterestAreaId()).toList()
                );
        }catch(Exception e){
            log.error("Error while fetching nested interest areas for interest area id: {}", id);
            throw new RuntimeException("Error while fetching nested interest areas for interest area id: " + id);
        }

        List <WikiTagDto> wikiTags;

        try{
            wikiTags =  wikiTagService.getWikiTags(entityTagsRepository.findAllByEntityIdAndEntityType(id, EntityType.INTEREST_AREA).stream().map(
                        entityTags -> entityTags.getWikiDataTagId()).toList());
        }catch(Exception e){
            throw e;
        }

        return InterestAreaDto.builder()
                .id(interestArea.get().getId())
                .enigmaUserId(interestArea.get().getEnigmaUserId())
                .title(interestArea.get().getTitle())
                .description(interestArea.get().getDescription())
                .accessLevel(interestArea.get().getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.get().getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String title, String description, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> wikiTags){

        if(!interestAreaRepository.existsAllByIdIsIn(nestedInterestAreas)){
            log.error("Nested interest areas not found for ids: {}", nestedInterestAreas);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Nested interest areas not found for ids: " + nestedInterestAreas);
        }

        wikiTags.forEach( wikiTag ->{
                if(!isValidWikidataId(wikiTag)){
                    log.error("Invalid wiki tag id: {}", wikiTag);
                    throw new EnigmaNotFoundException(ExceptionCodes.INVALID_WIKI_TAG_ID, "Invalid wiki tag id: " + wikiTag);
                }
            }
        );

        wikiTagService.getWikiTags(wikiTags);

        InterestArea interestArea = InterestArea.builder()
                .enigmaUserId(enigmaUserId)
                .title(title)
                .description(description)
                .accessLevel(accessLevel)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        interestAreaRepository.save(interestArea);

        nestedInterestAreas.forEach(nestedInterestArea -> {
            nestedInterestAreaRepository.save(
                    com.wia.enigma.dal.entity.NestedInterestArea.builder()
                            .parentInterestAreaId(interestArea.getId())
                            .childInterestAreaId(nestedInterestArea)
                            .createTime(new Timestamp(System.currentTimeMillis()))
                            .build()
            );
        });

        wikiTags.forEach(wikiTag -> {
            entityTagsRepository.save(
                    EntityTag.builder()
                            .entityId(interestArea.getId())
                            .entityType(EntityType.INTEREST_AREA)
                            .wikiDataTagId(wikiTag)
                            .createTime(new Timestamp(System.currentTimeMillis()))
                            .build()
            );
        });

        userFollowsService.follow(UserFollows.builder()
                .followerEnigmaUserId(enigmaUserId)
                .followedEntityId(interestArea.getId())
                .followedEntityType(EntityType.INTEREST_AREA)
                .isAccepted(true)
                .build());

        return InterestAreaSimpleDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .title(interestArea.getTitle())
                .accessLevel(interestArea.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto updateInterestArea(Long id, String title, String description, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> wikiTags){

        if(!interestAreaRepository.existsById(id)){
            log.error("Interest area not found for id: {}", id);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id);
        }

        if(!interestAreaRepository.existsAllByIdIsIn(nestedInterestAreas)){
            log.error("Nested interest areas not found for ids: {}", nestedInterestAreas);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Nested interest areas not found for ids: " + nestedInterestAreas);
        }

        wikiTags.forEach( wikiTag ->{
                    if(!isValidWikidataId(wikiTag)){
                        log.error("Invalid wiki tag id: {}", wikiTag);
                        throw new EnigmaNotFoundException(ExceptionCodes.INVALID_WIKI_TAG_ID, "Invalid wiki tag id: " + wikiTag);
                    }
                }
        );

        InterestArea interestArea = interestAreaRepository.findById(id).get();
        interestArea.setTitle(title);
        interestArea.setDescription(description);
        interestArea.setAccessLevel(accessLevel);

        interestAreaRepository.save(interestArea);

        nestedInterestAreaRepository.deleteAllByParentInterestAreaId(interestArea.getId());

        nestedInterestAreaRepository.saveAll(nestedInterestAreas.stream().map(
                nestedInterestArea -> com.wia.enigma.dal.entity.NestedInterestArea.builder()
                        .parentInterestAreaId(interestArea.getId())
                        .childInterestAreaId(nestedInterestArea)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()).toList()
                );

        entityTagsRepository.deleteAllByEntityIdAndEntityType(interestArea.getId(), EntityType.INTEREST_AREA);

        entityTagsRepository.saveAll(wikiTags.stream().map( wikiTag -> EntityTag.builder()
                .entityId(interestArea.getId())
                .entityType(EntityType.INTEREST_AREA)
                .wikiDataTagId(wikiTag)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build()).toList());

        return InterestAreaSimpleDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .title(interestArea.getTitle())
                .accessLevel(interestArea.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public void deleteInterestArea(Long id) {
        if(!interestAreaRepository.existsById(id)){
            log.error("Interest area not found for id: {}", id);
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id);
        }

        interestAreaRepository.deleteById(id);
    }

    @Override
    @Transactional
    public void followInterestArea(Long enigmaUserId, Long interestAreaId){

        InterestArea interestArea = interestAreaRepository.findInterestAreaById(interestAreaId);

        if(interestArea == null){
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + interestAreaId);
        }

        Optional<UserFollows> userFollows = userFollowsService.findUserFollowsEntity(enigmaUserId, interestAreaId, EntityType.USER);

        if(userFollows.isPresent()) {

            if(userFollows.get().getIsAccepted()){
                throw new IllegalArgumentException("You are already following this " + EntityType.INTEREST_AREA);
            }
            else {
                throw new IllegalArgumentException("You already sent a follow request to this " + EntityType.INTEREST_AREA);
            }
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
            throw new EnigmaNotFoundException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + interestAreaId);
        }

        userFollowsService.unfollow(enigmaUserId, interestAreaId, EntityType.INTEREST_AREA);
    }

    @Override
    public List<EnigmaUserDto> getFollowers(Long userId, Long followedId){

        InterestArea interestArea = interestAreaRepository.findById(followedId)
                .orElseThrow(() -> new IllegalArgumentException("Interest area not found"));

        if(!interestArea.getAccessLevel().equals(EnigmaAccessLevel.PRIVATE)){

            if(!userId.equals(interestArea.getEnigmaUserId())){

                throw new IllegalArgumentException("You cannot get followers of this interest area " + EntityType.INTEREST_AREA);
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

    private boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
    }
}
