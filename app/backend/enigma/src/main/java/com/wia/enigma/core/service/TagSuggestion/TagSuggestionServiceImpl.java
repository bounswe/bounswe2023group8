package com.wia.enigma.core.service.TagSuggestion;

import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.WikiTagSuggestionDto;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.EntityTagsRepository;
import com.wia.enigma.dal.repository.InterestAreaRepository;
import com.wia.enigma.dal.repository.TagSuggestionRepository;
import com.wia.enigma.dal.repository.WikiTagRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TagSuggestionServiceImpl implements TagSuggestionService{
    private final WikiTagRepository wikiTagRepository;

    final TagSuggestionRepository tagSuggestionRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaService interestAreaService;
    final InterestAreaRepository interestAreaRepository;
    final PostService postService;
    final WikiService wikiService;

    @Override
    public List<WikiTagSuggestionDto> getSuggestedTags(Long entityId, EntityType entityType, Long userId){

        List<String> wikiTagIds = null;

        if(entityType == EntityType.INTEREST_AREA) {

            InterestArea interestArea = interestAreaRepository.findById(entityId).orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found."));

            if(!interestArea.getEnigmaUserId().equals(userId)){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to view suggested tags.");
            }

            List<TagSuggestion> tagSuggestions = tagSuggestionRepository.findByEntityIdAndEntityType(entityId, entityType);

            wikiTagIds = tagSuggestions.stream()
                    .map(TagSuggestion::getWikiDataTagId).toList();

            List<WikiTag> wikiTags = wikiService.getWikiTags(wikiTagIds);

            return wikiTags.stream().map(wikiTag -> {
                TagSuggestion tagSuggestion = tagSuggestions.stream().filter(tagSuggestion1 -> tagSuggestion1.getWikiDataTagId().equals(wikiTag.getId())).findFirst().get();
                return WikiTagSuggestionDto.builder()
                        .id(tagSuggestion.getId())
                        .wikiDataTagId(wikiTag.getId())
                        .label(wikiTag.getLabel())
                        .description(wikiTag.getDescription())
                        .isValidTag(wikiTag.getIsValidTag())
                        .requesterCount(tagSuggestion.getRequesterCount())
                        .build();
            }).toList();

        }else {

            PostDto postDto = postService.getPost(entityId, userId);

            if (!postDto.getEnigmaUser().getId().equals(userId)) {

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to view suggested tags.");
            }

            List<TagSuggestion> tagSuggestions = tagSuggestionRepository.findByEntityIdAndEntityType(entityId, entityType);

            wikiTagIds = tagSuggestions.stream()
                    .map(TagSuggestion::getWikiDataTagId).toList();

            List<WikiTag> wikiTags = wikiService.getWikiTags(wikiTagIds);


            return wikiTags.stream().map(wikiTag -> {
                TagSuggestion tagSuggestion = tagSuggestions.stream().filter(tagSuggestion1 -> tagSuggestion1.getWikiDataTagId().equals(wikiTag.getId())).findFirst().get();
                return WikiTagSuggestionDto.builder()
                        .id(tagSuggestion.getId())
                        .wikiDataTagId(wikiTag.getId())
                        .label(wikiTag.getLabel())
                        .description(wikiTag.getDescription())
                        .isValidTag(wikiTag.getIsValidTag())
                        .requesterCount(tagSuggestion.getRequesterCount())
                        .build();
            }).toList();
        }

    }

    @Override
    public void suggestTags(List<String> suggestedTags, Long entityId, EntityType entityType, Long userId) {

        if(entityType == EntityType.INTEREST_AREA) {

            interestAreaService.getInterestArea(entityId, userId);
        }else{

            postService.getPost(entityId, userId);

        }

        Set<String> distinctSuggestedTags = new HashSet<>(suggestedTags);

        distinctSuggestedTags.forEach(tag -> {
            if (!isValidWikidataId(tag)) {
                String errorMessage = "Invalid wiki tag id: " + tag;

                throw new EnigmaException(ExceptionCodes.INVALID_WIKI_TAG_ID, errorMessage);
            }
        });

        List<TagSuggestion> existingTagSuggestions = tagSuggestionRepository.findByEntityIdAndEntityType(entityId, entityType);
        Map<String, TagSuggestion> tagSuggestionMap = existingTagSuggestions.stream()
                .collect(Collectors.toMap(TagSuggestion::getWikiDataTagId, Function.identity()));

        Set<String> existingTags = entityTagsRepository.findAllByEntityIdAndEntityType(entityId, entityType)
                .stream().map(EntityTag::getWikiDataTagId).collect(Collectors.toSet());

        List<TagSuggestion> allTagSuggestions = new ArrayList<>();

        for (String tag : distinctSuggestedTags) {
            if (!existingTags.contains(tag)) {
                if (tagSuggestionMap.containsKey(tag)) {
                    TagSuggestion existingTagSuggestion = tagSuggestionMap.get(tag);
                    allTagSuggestions.add(TagSuggestion.builder()
                            .id(existingTagSuggestion.getId())
                            .entityId(entityId)
                            .entityType(entityType)
                            .wikiDataTagId(tag)
                            .requesterCount(existingTagSuggestion.getRequesterCount() + 1)
                            .build());
                } else {
                    allTagSuggestions.add(TagSuggestion.builder()
                            .entityId(entityId)
                            .entityType(entityType)
                            .wikiDataTagId(tag)
                            .requesterCount(1L)
                            .build());
                }
            }
        }
        tagSuggestionRepository.saveAll(allTagSuggestions);
    }

    @Override
    public void acceptTagSuggestion(Long tagSuggestionId, Long userId){

        TagSuggestion tagSuggestion = tagSuggestionRepository.findById(tagSuggestionId).orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, "Tag suggestion not found."));

        if(tagSuggestion.getEntityType() == EntityType.INTEREST_AREA) {

            InterestArea interestArea = interestAreaRepository.findById(tagSuggestion.getEntityId()).orElseThrow(() -> new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found."));

            if(!interestArea.getEnigmaUserId().equals(userId)){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to accept tag suggestion.");
            }

            wikiTagRepository.saveAll(wikiService.getWikiTags(List.of(tagSuggestion.getWikiDataTagId())));

            List<EntityTag> existingEntityTags = entityTagsRepository.findAllByEntityIdAndEntityType(interestArea.getId(), EntityType.INTEREST_AREA);

            Set<String> existingTags = existingEntityTags.stream().map(EntityTag::getWikiDataTagId).collect(Collectors.toSet());

            if(existingTags.contains(tagSuggestion.getWikiDataTagId())){

                throw new EnigmaException(ExceptionCodes.INVALID_REQUEST, "Tag already exists.");
            }

            entityTagsRepository.save(EntityTag.builder()
                    .entityId(interestArea.getId())
                    .entityType(EntityType.INTEREST_AREA)
                    .wikiDataTagId(tagSuggestion.getWikiDataTagId())
                    .build());

            tagSuggestionRepository.delete(tagSuggestion);

        }else{

            PostDto post = postService.getPost(tagSuggestion.getEntityId(), userId);

            if(!post.getEnigmaUser().getId().equals(userId)){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to accept tag suggestion.");
            }

            List<EntityTag> existingEntityTags = entityTagsRepository.findAllByEntityIdAndEntityType(post.getId(), EntityType.POST);

            Set<String> existingTags = existingEntityTags.stream().map(EntityTag::getWikiDataTagId).collect(Collectors.toSet());

            if(existingTags.contains(tagSuggestion.getWikiDataTagId())){

                throw new EnigmaException(ExceptionCodes.INVALID_REQUEST, "Tag already exists.");
            }

            wikiTagRepository.saveAll(wikiService.getWikiTags(List.of(tagSuggestion.getWikiDataTagId())));

            entityTagsRepository.save(EntityTag.builder()
                    .entityId(post.getId())
                    .entityType(EntityType.POST)
                    .wikiDataTagId(tagSuggestion.getWikiDataTagId())
                    .build());

            tagSuggestionRepository.delete(tagSuggestion);
        }
    }

    @Override
    public void rejectTagSuggestion(Long tagSuggestionId, Long userId){

        TagSuggestion tagSuggestion = tagSuggestionRepository.findById(tagSuggestionId).orElseThrow(() ->
                new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, "Tag suggestion not found."));

        if(tagSuggestion.getEntityType() == EntityType.INTEREST_AREA) {

            InterestArea interestArea = interestAreaRepository.findById(tagSuggestion.getEntityId()).orElseThrow(() ->
                    new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area not found."));

            if(!interestArea.getEnigmaUserId().equals(userId)){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to reject tag suggestion.");
            }

            tagSuggestionRepository.delete(tagSuggestion);

        }else{

            PostDto post = postService.getPost(tagSuggestion.getEntityId(), userId);

            if(!post.getEnigmaUser().getId().equals(userId)){

                throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User is not authorized to reject tag suggestion.");
            }

            tagSuggestionRepository.delete(tagSuggestion);
        }
    }


    boolean isValidWikidataId(String id) {
        return id.matches("Q[0-9]+");
    }
}



