package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.entity.WikiTag;
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

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaServiceImpl implements InterestAreaService {
    private final WikiTagRepository wikiTagRepository;

    final InterestAreaRepository interestAreaRepository;
    final EntityTagsRepository entityTagsRepository;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;

    final InterestAreaServiceHelper interestAreaServiceHelper;


    @Override
    @Transactional(readOnly = true)
    public InterestAreaDto getInterestArea(Long id, Long enigmaUserId) {

        InterestArea interestArea = interestAreaRepository.findById(id)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + id));

        interestAreaServiceHelper.checkInterestAreaAccess(interestArea, enigmaUserId);

        List<WikiTag> wikiTags = interestAreaServiceHelper.getWikiTags(id);

        return interestArea.mapToInterestAreaDto(wikiTags);
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String title, String description,
                                                    EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas,
                                                    List<String> wikiTags) {

        interestAreaServiceHelper.validateWikiTags(wikiTags);

        InterestArea interestArea = interestAreaServiceHelper.createAndSaveInterestArea(enigmaUserId, title, description, accessLevel);

        interestAreaServiceHelper.validateNestedInterestAreas(nestedInterestAreas, interestArea);

        interestAreaServiceHelper.saveNestedInterestAreas(nestedInterestAreas, interestArea);

        wikiTagRepository.saveAll(wikiTagService.getWikiTags(wikiTags));

        interestAreaServiceHelper.saveEntityTags(wikiTags, interestArea);

        interestAreaServiceHelper.followInterestAreaWhenCreated(enigmaUserId, interestArea);

        return interestArea.mapToInterestAreaSimpleDto( nestedInterestAreas, wikiTags);
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto updateInterestArea(Long id, String title, String description,
                                                    EnigmaAccessLevel accessLevel,
                                                    List<Long> nestedInterestAreas,
                                                    List<String> wikiTags) {

        InterestArea interestArea = interestAreaServiceHelper.updateInterestAreaDetails(id, title, description, accessLevel);

        interestAreaServiceHelper.validateNestedInterestAreas(nestedInterestAreas, interestArea );
        interestAreaServiceHelper.validateWikiTags(wikiTags);


        interestAreaServiceHelper.updateNestedInterestAreas(interestArea, nestedInterestAreas);
        wikiTagRepository.saveAll(wikiTagService.getWikiTags(wikiTags));
        interestAreaServiceHelper.updateWikiTags(interestArea, wikiTags);

        return interestArea.mapToInterestAreaSimpleDto( nestedInterestAreas, wikiTags);
    }

    @Override
    @Transactional
    public void deleteInterestArea(Long id) {

        interestAreaServiceHelper.checkInterestAreaExist(id);

        interestAreaRepository.deleteById(id);

        interestAreaServiceHelper.deleteRelatedEntities(id);
    }

    @Override
    @Transactional
    public void followInterestArea(Long enigmaUserId, Long interestAreaId){

        InterestArea interestArea = interestAreaServiceHelper.getInterestArea(interestAreaId);

        interestAreaServiceHelper.followInterestArea(enigmaUserId, interestArea);
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
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found for id: " + followedId));

        if(interestArea.getAccessLevel().equals(EnigmaAccessLevel.PRIVATE)){

            if(!userId.equals(interestArea.getEnigmaUserId())){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "You cannot get followers of this interest area type:" + EnigmaAccessLevel.PRIVATE);
            }
        }

        return interestAreaServiceHelper.getFollowers(userId, followedId);
    }

    @Override
    public List<InterestArea> getNestedInterestAreas(Long id, Long enigmaUserId) {

        return interestAreaServiceHelper.getNestedInterestAreas(id, enigmaUserId);
    }

        @Override
    public List<InterestAreaSimpleDto>  search(Long userId, String searchKey){


        List <WikiTag> wikiTags = wikiTagRepository.findByLabelContainsOrDescriptionContains(searchKey, searchKey);

        List<Long> relatedInterestAreaIds =  entityTagsRepository.findByWikiDataTagIdInAndEntityType(wikiTags.stream()
                                .map( wikiTag -> wikiTag.getId()).toList(), EntityType.INTEREST_AREA)
                .stream()
                .map(entityTag -> entityTag.getEntityId()).toList();

        return interestAreaRepository.findByAccessLevelNotAndTitleContainsOrIdIn(EnigmaAccessLevel.PERSONAL, searchKey, relatedInterestAreaIds).stream()
                .map(interestArea -> InterestAreaSimpleDto.builder()
                        .id(interestArea.getId())
                        .enigmaUserId(interestArea.getEnigmaUserId())
                        .title(interestArea.getTitle())
                        .description(interestArea.getDescription())
                        .accessLevel(interestArea.getAccessLevel())
                        .createTime(interestArea.getCreateTime())
                        .build()
                ).toList();
    }

    @Override
    public Boolean checkInterestAreaExist(Long id) {
        return interestAreaServiceHelper.checkInterestAreaExist(id);
    }
}
