package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.PostLabel;
import com.wia.enigma.dal.repository.EntityTagsRepository;
import com.wia.enigma.dal.repository.InterestAreaPostRepository;
import com.wia.enigma.dal.repository.PostRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostServiceImpl implements PostService{

    final PostRepository postRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;
    final InterestAreaService interestAreaService;

    @Override
    public PostDto getPost(Long postId, Long userId) {

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));


        if(!userFollowsService.isUserFollowsEntity(userId, post.getInterestAreaId(), EntityType.INTEREST_AREA)){

            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not following interest area %d", userId, post.getInterestAreaId()));
        }

        List <WikiTagDto> wikiTags;
        try{
            wikiTags =  wikiTagService.getWikiTags(entityTagsRepository.findAllByEntityIdAndEntityType(post.getId(), EntityType.POST).stream().map(
                    entityTags -> entityTags.getWikiDataTagId()).toList());
        }catch(Exception e){
            throw new EnigmaException(ExceptionCodes.INTERNAL_SERVER_ERROR, "Error occurred while fetching wiki tags.");
        }


        return PostDto.builder()
                .id(post.getId())
                .enigmaUserId(post.getEnigmaUserId())
                .interestAreaId(post.getInterestAreaId())
                .sourceLink(post.getSourceLink())
                .title(post.getTitle())
                .wikiTags(wikiTags)
                .label(post.getLabel())
                .geolocation(post.getGeolocation())
                .createTime(post.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink, String title, List<String> wikiTags, PostLabel label, GeoLocation geolocation) {

        if(interestAreaService.isInterestAreaExist(interestAreaId) == false)
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, String.format("Interest area %d not found", interestAreaId));

        if(!userFollowsService.isUserFollowsEntity(userId, interestAreaId, EntityType.INTEREST_AREA))
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not following interest area %d", userId, interestAreaId));

        Post post = Post.builder()
                .enigmaUserId(userId)
                .interestAreaId(interestAreaId)
                .sourceLink(sourceLink)
                .title(title)
                .label(label)
                .geolocation(geolocation)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        postRepository.save(post);

        wikiTags.forEach(wikiTag -> {
            entityTagsRepository.save(
                    EntityTag.builder()
                            .entityId(post.getId())
                            .entityType(EntityType.POST)
                            .wikiDataTagId(wikiTag)
                            .createTime(new Timestamp(System.currentTimeMillis()))
                            .build()
            );
        });


        interestAreaPostRepository.save(
                com.wia.enigma.dal.entity.InterestAreaPost.builder()
                        .interestAreaId(interestAreaId)
                        .postId(post.getId())
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        );

        return PostDtoSimple.builder()
                .id(post.getId())
                .enigmaUserId(post.getEnigmaUserId())
                .interestAreaId(post.getInterestAreaId())
                .sourceLink(post.getSourceLink())
                .title(post.getTitle())
                .wikiTags(wikiTags)
                .label(post.getLabel())
                .geolocation(post.getGeolocation())
                .createTime(post.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public PostDtoSimple updatePost(Long userId, Long postId, String sourceLink, String title, List<String> wikiTags, PostLabel label, GeoLocation geolocation) {

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));

        if(post.getEnigmaUserId() != userId)
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post %d", userId, post.getId()));


        post.setSourceLink(sourceLink);
        post.setTitle(title);
        post.setLabel(label);
        post.setGeolocation(geolocation);
        post.setCreateTime(new Timestamp(System.currentTimeMillis()));

        postRepository.save(post);

        entityTagsRepository.deleteAllByEntityIdAndEntityType(post.getId(), EntityType.POST);

        wikiTags.forEach(wikiTag -> {
            entityTagsRepository.save(
                    EntityTag.builder()
                            .entityId(post.getId())
                            .entityType(EntityType.POST)
                            .wikiDataTagId(wikiTag)
                            .createTime(new Timestamp(System.currentTimeMillis()))
                            .build()
            );
        });

        return PostDtoSimple.builder()
                .id(post.getId())
                .enigmaUserId(post.getEnigmaUserId())
                .interestAreaId(post.getInterestAreaId())
                .sourceLink(post.getSourceLink())
                .title(post.getTitle())
                .wikiTags(wikiTags)
                .label(post.getLabel())
                .geolocation(post.getGeolocation())
                .createTime(post.getCreateTime())
                .build();
    }

    @Override
    @Transactional
    public void deletePost(Long postId, Long userId) {

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));

        if(post.getEnigmaUserId() != userId){
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post %d", userId, post.getId()));
        }

        postRepository.delete(post);
    }
}
