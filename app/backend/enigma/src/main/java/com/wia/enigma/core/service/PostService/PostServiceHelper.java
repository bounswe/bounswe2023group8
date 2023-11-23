package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.entity.InterestAreaPost;
import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.PostLabel;
import com.wia.enigma.dal.repository.EntityTagsRepository;
import com.wia.enigma.dal.repository.InterestAreaPostRepository;
import com.wia.enigma.dal.repository.PostRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
class PostServiceHelper {

    final PostRepository postRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;
    final InterestAreaService interestAreaService;


    Post fetchPost(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));
    }

    void validateUserFollowsInterestArea(Long userId, Post post) {
        if (!userFollowsService.isUserFollowsEntity(userId, post.getInterestAreaId(), EntityType.INTEREST_AREA)) {
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not following interest area %d", userId, post.getInterestAreaId()));
        }
    }

    List<WikiTagDto> fetchWikiTagsForPost(Post post) {
        return wikiTagService.getWikiTags(
                entityTagsRepository.findAllByEntityIdAndEntityType(post.getId(), EntityType.POST).stream()
                        .map(EntityTag::getWikiDataTagId)
                        .collect(Collectors.toList())
        );
    }

    void validateInterestAreaAndUserFollowing(Long interestAreaId, Long userId) {

        interestAreaService.checkInterestAreaExist(interestAreaId);

        if (!userFollowsService.isUserFollowsEntity(userId, interestAreaId, EntityType.INTEREST_AREA))
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User " + userId + " is not following interest area " + interestAreaId);
    }

    Post createAndSavePost(Long userId, Long interestAreaId, String sourceLink,
                                   String title, PostLabel label, String content, GeoLocation geolocation) {
        Post post = Post.builder()
                .enigmaUserId(userId)
                .interestAreaId(interestAreaId)
                .sourceLink(sourceLink)
                .title(title)
                .label(label)
                .content(content)
                .geolocation(geolocation)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        return postRepository.save(post);
    }

    void saveWikiTagsForPost(Post post, List<String> wikiTags) {
        List<EntityTag> entityTags = wikiTags.stream().map(wikiTag ->
                EntityTag.builder()
                        .entityId(post.getId())
                        .entityType(EntityType.POST)
                        .wikiDataTagId(wikiTag)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        entityTagsRepository.saveAll(entityTags);
    }

    void saveInterestAreaPost(Long interestAreaId, Post post) {
        InterestAreaPost interestAreaPost = InterestAreaPost.builder()
                .interestAreaId(interestAreaId)
                .postId(post.getId())
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        interestAreaPostRepository.save(interestAreaPost);
    }

    void validatePostOwnership(Long userId, Post post) {
        if (!post.getEnigmaUserId().equals(userId)) {
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User " + userId + " is not the owner of post " + post.getId());
        }
    }

    void updatePostDetails(Post post, String sourceLink, String title,
                                   PostLabel label, String content, GeoLocation geolocation) {
        post.setSourceLink(sourceLink);
        post.setTitle(title);
        post.setLabel(label);
        post.setContent(content);
        post.setGeolocation(geolocation);
        post.setCreateTime(new Timestamp(System.currentTimeMillis()));
        postRepository.save(post);
    }

    void updateWikiTagsForPost(Post post, List<String> wikiTags) {
        entityTagsRepository.deleteAllByEntityIdAndEntityType(post.getId(), EntityType.POST);

        List<EntityTag> entityTags = wikiTags.stream().map(wikiTag ->
                EntityTag.builder()
                        .entityId(post.getId())
                        .entityType(EntityType.POST)
                        .wikiDataTagId(wikiTag)
                        .createTime(new Timestamp(System.currentTimeMillis()))
                        .build()
        ).collect(Collectors.toList());

        entityTagsRepository.saveAll(entityTags);
    }
}