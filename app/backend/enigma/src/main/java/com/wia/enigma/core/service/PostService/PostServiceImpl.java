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
public class PostServiceImpl implements PostService{

    final PostRepository postRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;
    final InterestAreaService interestAreaService;

    @Override
    public PostDto getPost(Long postId, Long userId) {
        Post post = fetchPost(postId);
        validateUserFollowsInterestArea(userId, post);

        List<WikiTagDto> wikiTags = fetchWikiTagsForPost(post);

        return mapToPostDto(post, wikiTags);
    }

    @Override
    @Transactional
    public PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink,
                                    String title, List<String> wikiTags, PostLabel label,
                                    GeoLocation geolocation) {

        validateInterestAreaAndUserFollowing(interestAreaId, userId);
        Post post = createAndSavePost(userId, interestAreaId, sourceLink, title, label, geolocation);
        saveWikiTagsForPost(post, wikiTags);
        saveInterestAreaPost(interestAreaId, post);

        return mapToPostDtoSimple(post, wikiTags);
    }

    @Override
    @Transactional
    public PostDtoSimple updatePost(Long userId, Long postId, String sourceLink,
                                    String title, List<String> wikiTags,
                                    PostLabel label, GeoLocation geolocation) {

        Post post = fetchPost(postId);
        validatePostOwnership(userId, post);

        updatePostDetails(post, sourceLink, title, label, geolocation);
        updateWikiTagsForPost(post, wikiTags);

        return mapToPostDtoSimple(post, wikiTags);
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

    private Post fetchPost(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));
    }

    private void validateUserFollowsInterestArea(Long userId, Post post) {
        if (!userFollowsService.isUserFollowsEntity(userId, post.getInterestAreaId(), EntityType.INTEREST_AREA)) {
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not following interest area %d", userId, post.getInterestAreaId()));
        }
    }

    private List<WikiTagDto> fetchWikiTagsForPost(Post post) {
        return wikiTagService.getWikiTags(
                entityTagsRepository.findAllByEntityIdAndEntityType(post.getId(), EntityType.POST).stream()
                        .map(EntityTag::getWikiDataTagId)
                        .collect(Collectors.toList())
        );
    }

    private PostDto mapToPostDto(Post post, List<WikiTagDto> wikiTags) {
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

    private void validateInterestAreaAndUserFollowing(Long interestAreaId, Long userId) {
        if (!interestAreaService.isInterestAreaExist(interestAreaId))
            throw new EnigmaException(ExceptionCodes.INTEREST_AREA_NOT_FOUND, "Interest area " + interestAreaId + " not found");

        if (!userFollowsService.isUserFollowsEntity(userId, interestAreaId, EntityType.INTEREST_AREA))
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User " + userId + " is not following interest area " + interestAreaId);
    }

    private Post createAndSavePost(Long userId, Long interestAreaId, String sourceLink,
                                   String title, PostLabel label, GeoLocation geolocation) {
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

    private void saveWikiTagsForPost(Post post, List<String> wikiTags) {
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

    private void saveInterestAreaPost(Long interestAreaId, Post post) {
        InterestAreaPost interestAreaPost = InterestAreaPost.builder()
                .interestAreaId(interestAreaId)
                .postId(post.getId())
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        interestAreaPostRepository.save(interestAreaPost);
    }

    private PostDtoSimple mapToPostDtoSimple(Post post, List<String> wikiTags) {
        return PostDtoSimple.builder()
                .id(post.getId())
                .enigmaUserId(post.getEnigmaUserId())
                .interestAreaId(post.getInterestAreaId())
                .sourceLink(post.getSourceLink())
                .title(post.getTitle())
                .wikiTags(wikiTags)
                .label(post.getLabel())
                .content(post.getContent())
                .geolocation(post.getGeolocation())
                .createTime(post.getCreateTime())
                .build();
    }

    private void validatePostOwnership(Long userId, Post post) {
        if (!post.getEnigmaUserId().equals(userId)) {
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, "User " + userId + " is not the owner of post " + post.getId());
        }
    }

    private void updatePostDetails(Post post, String sourceLink, String title,
                                   PostLabel label, GeoLocation geolocation) {
        post.setSourceLink(sourceLink);
        post.setTitle(title);
        post.setLabel(label);
        post.setContent(content);
        post.setGeolocation(geolocation);
        post.setCreateTime(new Timestamp(System.currentTimeMillis()));
        postRepository.save(post);
    }

    private void updateWikiTagsForPost(Post post, List<String> wikiTags) {
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
