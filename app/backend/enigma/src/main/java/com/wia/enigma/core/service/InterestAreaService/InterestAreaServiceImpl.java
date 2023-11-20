package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.EntityTagsRepository;
import com.wia.enigma.dal.repository.InterestAreaRepository;
import com.wia.enigma.dal.repository.NestedInterestAreaRepository;
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

    @Override
    @Transactional(readOnly = true)
    public InterestAreaDto getInterestArea(Long id) {

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
                .name(interestArea.get().getName())
                .accessLevel(interestArea.get().getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.get().getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String name, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> wikiTags){

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
                .name(name)
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

        return InterestAreaSimpleDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .name(interestArea.getName())
                .accessLevel(interestArea.getAccessLevel())
                .nestedInterestAreas(nestedInterestAreas)
                .wikiTags(wikiTags)
                .createTime(interestArea.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public InterestAreaSimpleDto updateInterestArea(Long id, String name, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> wikiTags){

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
        interestArea.setName(name);
        interestArea.setAccessLevel(accessLevel);

        interestAreaRepository.save(interestArea);

        nestedInterestAreaRepository.saveAll(nestedInterestAreas.stream().map(
                nestedInterestArea -> com.wia.enigma.dal.entity.NestedInterestArea.builder()
                        .parentInterestAreaId(interestArea.getId())
                        .childInterestAreaId(nestedInterestArea)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()).toList()
                );

        entityTagsRepository.saveAll(wikiTags.stream().map( wikiTag -> EntityTag.builder()
                .entityId(interestArea.getId())
                .entityType(EntityType.INTEREST_AREA)
                .wikiDataTagId(wikiTag)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build()).toList());

        return InterestAreaSimpleDto.builder()
                .id(interestArea.getId())
                .enigmaUserId(interestArea.getEnigmaUserId())
                .name(interestArea.getName())
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

    private boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
    }
}
