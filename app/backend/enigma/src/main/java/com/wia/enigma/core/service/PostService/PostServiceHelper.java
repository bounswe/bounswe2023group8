package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.service.InterestAreaPostService.InterestAreaPostService;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaServiceHelper;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.PostLabel;
import com.wia.enigma.dal.repository.*;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Collection;
import java.util.Collections;
import java.util.List;
import java.util.function.Function;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
@RequiredArgsConstructor
class PostServiceHelper {

    final PostRepository postRepository;
    final EntityTagsRepository entityTagsRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final InterestAreaPostService interestAreaPostService;
    final WikiService wikiTagService;
    final UserFollowsService userFollowsService;
    final InterestAreaService interestAreaService;
    final InterestAreaServiceHelper interestAreaServiceHelper;
    final EnigmaUserService enigmaUserService;
    private final EnigmaUserRepository enigmaUserRepository;
    private final WikiTagRepository wikiTagRepository;
    private final PostVoteRepository postVoteRepository;
    private final PostCommentRepository postCommentRepository;


    Post fetchPost(Long postId) {
        return postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));
    }

    void checkInterestAreaAccess(Long interestAreaId,  Long userId) {
        userFollowsService.checkInterestAreaAccess(interestAreaServiceHelper.getInterestArea(interestAreaId), userId);
    }

    List<WikiTag> fetchWikiTagsForPost(Post post) {
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

    Post createAndSavePost(Long userId, EnigmaAccessLevel accessLevel, Long interestAreaId, String sourceLink,
                           String title, PostLabel label, String content, GeoLocation geolocation) {
        Post post = Post.builder()
                .enigmaUserId(userId)
                .accessLevel(accessLevel)
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

    List<WikiTag> getWikiTags(Long id) {
        return wikiTagRepository.findAllById(entityTagsRepository.findAllByEntityIdAndEntityType(id, EntityType.POST).stream()
                .map(EntityTag::getWikiDataTagId)
                .collect(Collectors.toList()));
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


    List<PostDto> getInterestAreaPosts(Long interestAreaId, Long userId) {

        InterestArea interestArea = interestAreaServiceHelper.getInterestArea(interestAreaId);

        userFollowsService.checkInterestAreaAccess(interestArea, userId); ;

        List<Long> postIds =  interestAreaPostService.getPostsByInterestAreaId(interestAreaId).stream()
                .map(InterestAreaPost::getPostId).toList();


        List<EntityTag> entityTags =  entityTagsRepository.findByEntityIdInAndEntityType( postIds, EntityType.POST );


        List<WikiTag> wikiTags = wikiTagRepository.findAllById(
                entityTags.stream()
                        .map(EntityTag::getWikiDataTagId)
                        .collect(Collectors.toList())
              );
        List<Post> posts = postRepository.findAllById(postIds);

        List<Long> userIds = posts.stream().map(Post::getEnigmaUserId).toList();

        List<EnigmaUser> enigmaUsers = enigmaUserRepository.findAllById(userIds);


        List<InterestArea> nestedInterestAreas = interestAreaService.getNestedInterestAreas(interestAreaId, userId);

        List<Long> nestedInterestAreaIds = nestedInterestAreas.stream().map( interestArea1 -> interestArea1.getId() ).toList();


        Stream<PostDto> nestedInterestAreaPosts = nestedInterestAreaIds.stream()
                .flatMap(interestAreaId1 -> getInterestAreaPosts(interestAreaId1, userId).stream());

        Stream<PostDto> interestAreaPosts =  posts.stream().map(post -> {
              EnigmaUser enigmaUser = enigmaUsers.stream().filter(enigmaUser1 -> enigmaUser1.getId().equals(post.getEnigmaUserId())).findFirst().get();
              return post.mapToPostDto(
                      wikiTags.stream().filter(wikiTag ->
                          entityTags.stream().filter(entityTag -> entityTag.getEntityId().equals(post.getId()))
                                  .map(EntityTag::getWikiDataTagId).collect(Collectors.toList()).contains(wikiTag.getId()))
                          .collect(Collectors.toList()),
                        enigmaUser.mapToEnigmaUserDto(),
                        interestArea.mapToInterestAreaModel(),
                        postVoteRepository.countByPostIdAndVote(post.getId(), true),
                        postVoteRepository.countByPostIdAndVote(post.getId(), false),
                        postCommentRepository.countByPostId(post.getId())
                      );
         });

        return Stream.concat(interestAreaPosts, nestedInterestAreaPosts)
                .collect(Collectors.toList());
    }

    List<PostDto> search(Long userId, String searchKey){


        List<Post> post = postRepository.findByTitleContainsOrContentContainsOrSourceLinkContains(searchKey, searchKey, searchKey);

        List<Post> filteredPosts =  post.stream().filter(post1 -> post1.getAccessLevel().equals(EnigmaAccessLevel.PUBLIC) ||  userFollowsService.isUserFollowsEntity(userId, post1.getInterestAreaId(), EntityType.INTEREST_AREA)).toList();

        List<Long> filteredPostIds = filteredPosts.stream().map(Post::getId).toList();

        List<EntityTag> entityTags =  entityTagsRepository.findByEntityIdInAndEntityType( filteredPostIds, EntityType.POST );

        List<WikiTag> wikiTags = wikiTagRepository.findAllById(
                entityTags.stream()
                        .map(EntityTag::getWikiDataTagId)
                        .collect(Collectors.toList())
        );

        List<Long> userIds = filteredPosts.stream().map(Post::getEnigmaUserId).toList();


        List<EnigmaUser> enigmaUsers = enigmaUserRepository.findAllById(userIds);

        return filteredPosts.stream().map(post1 -> {
            EnigmaUser enigmaUser = enigmaUsers.stream().filter(enigmaUser1 -> enigmaUser1.getId().equals(post1.getEnigmaUserId())).findFirst().get();
            return post1.mapToPostDto(
                    wikiTags,
                    enigmaUser.mapToEnigmaUserDto(),
                    interestAreaServiceHelper.getInterestArea(post1.getInterestAreaId()).mapToInterestAreaModel(),
                    postVoteRepository.countByPostIdAndVote(post1.getId(), true),
                    postVoteRepository.countByPostIdAndVote(post1.getId(), false),
                    postCommentRepository.countByPostId(post1.getId())
            );
        }).toList();
    }
}
