package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.service.ModerationService;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.PostLabel;
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
import java.util.Objects;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostServiceImpl implements PostService {
    private final EntityTagsRepository entityTagsRepository;

    final PostCommentRepository postCommentRepository;
    final PostVoteRepository postVoteRepository;
    final InterestAreaRepository interestAreaRepository;
    final WikiTagRepository wikiTagRepository;
    final EnigmaUserRepository enigmaUserRepository;
    final InterestAreaPostRepository interestAreaPostRepository;

    final PostRepository postRepository;
    final PostServiceHelper postServiceHelper;
    final WikiService wikiTagService;
    final ModerationService moderationService;

    @Override
    public PostDto getPost(Long postId, Long userId) {

        EnigmaUser enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        Post post = postServiceHelper.fetchPost(postId);
        moderationService.assertNotBanned(enigmaUser.getId(), postId, post.getInterestAreaId());

        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);
        postServiceHelper.checkAgeRestriction(post, enigmaUser);

        List<WikiTag> wikiTags = postServiceHelper.getWikiTags(postId);

        InterestArea interestArea = interestAreaRepository.findInterestAreaById(post.getInterestAreaId());


        EnigmaUser user = enigmaUserRepository.findEnigmaUserById(post.getEnigmaUserId());

        if(enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Enigma user %d not found", post.getEnigmaUserId()));

        return post.mapToPostDto(
                wikiTags,
                user.mapToEnigmaUserDto(),
                interestArea.mapToInterestAreaModel(),
                postVoteRepository.countByPostIdAndVote(postId, true),
                postVoteRepository.countByPostIdAndVote(postId, false),
                postCommentRepository.countByPostId(postId)
        );
    }

    @Override
    @Transactional
    public PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink,
                                    String title, List<String> wikiTags, PostLabel label, String content,
                                    Boolean isAgeRestricted, GeoLocation geolocation) {

        postServiceHelper.validateInterestAreaAndUserFollowing(interestAreaId, userId);

        InterestArea interestArea = interestAreaRepository.findInterestAreaById(interestAreaId);

        Post post = postServiceHelper.createAndSavePost(userId,interestArea.getAccessLevel(), interestAreaId,  sourceLink, title, label, content, isAgeRestricted, geolocation);

        wikiTagRepository.saveAll(wikiTagService.getWikiTags(wikiTags));

        postServiceHelper.saveWikiTagsForPost(post, wikiTags);
        postServiceHelper.saveInterestAreaPost(interestAreaId, post);

        return post.mapToPostDtoSimple(wikiTags);
    }

    @Override
    @Transactional
    public PostDtoSimple updatePost(Long userId, Long postId, String sourceLink,
                                    String title, List<String> wikiTags,
                                    PostLabel label, String content, GeoLocation geolocation) {

        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.validatePostOwnership(userId, post);
        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());

        postServiceHelper.updatePostDetails(post, sourceLink, title, label, content, geolocation);

        wikiTagRepository.saveAll(wikiTagService.getWikiTags(wikiTags));

        postServiceHelper.updateWikiTagsForPost(post, wikiTags);

        return post.mapToPostDtoSimple(wikiTags);
    }

    @Override
    @Transactional
    public void deletePost(Long postId, Long userId) {

        Post post = postRepository.findById(postId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post %d not found", postId)));

        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());

        if(!Objects.equals(post.getEnigmaUserId(), userId)){
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post %d", userId, post.getId()));
        }

        postRepository.delete(post);
    }

    @Override
    @Transactional
    public void votePost(Long postId, Long userId, Boolean vote) {

        Post post = postServiceHelper.fetchPost(postId);

        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);
        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());

        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        PostVote postVote = postVoteRepository.findByEnigmaUserIdAndPostId(userId, postId);

        if(postVote == null){
            if(vote == null) return;

            postVote = PostVote.builder()
                    .enigmaUserId(userId)
                    .postId(postId)
                    .vote(vote)
                    .createTime(new Timestamp(System.currentTimeMillis()))
                    .build();
            postVoteRepository.save(postVote);
        }else{

            if(vote == null){
                postVoteRepository.delete(postVote);
                return;
            }

            postVote.setVote(vote);
            postVoteRepository.save(postVote);
        }
    }

    @Override
    public List<PostVoteDto> getPostVotes(Long postId, Long userId){

        Post post = postServiceHelper.fetchPost(postId);

        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);
        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());

        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        return postVoteRepository.findByPostId(postId).stream().map(

                postVote -> {
                    EnigmaUser enigmaUser = enigmaUserRepository.findEnigmaUserById(postVote.getEnigmaUserId());
                    return PostVoteDto.builder()
                            .id(postVote.getId())
                            .postId(postVote.getPostId())
                            .enigmaUser(enigmaUser.mapToEnigmaUserDto())
                            .isUpvote(postVote.getVote())
                            .build();
                }
        ).collect(Collectors.toList()
        );
    }

    @Override
    public List<PostDto> getInterestAreaPosts(Long interestAreaId, Long userId) {

        moderationService.assertNotBanned(userId, interestAreaId);

        return postServiceHelper.getInterestAreaPosts(interestAreaId, userId );
    }

    @Override
    public List<PostDto> search(Long userId, String searchKey) {
        return postServiceHelper.search(userId, searchKey);
    }

    @Override
    public void commentOnPost(Long postId, Long userId, String content) {

        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);

        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());
        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        PostComment postComment = PostComment.builder()
                .enigmaUserId(userId)
                .postId(postId)
                .content(content)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        postCommentRepository.save(postComment);
    }

    @Override
    public void updatePostComment(Long postId, Long userId, Long commentId, String content) {

        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);

        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());
        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        PostComment postComment = postCommentRepository.findById(commentId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post comment %d not found", commentId)));

        if(!postComment.getEnigmaUserId().equals(userId)){
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post comment %d", userId, postComment.getId()));
        }

        postComment.setContent(content);
        postCommentRepository.save(postComment);
    }

    @Override
    public void deletePostComment(Long postId, Long userId, Long commentId) {

        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);

        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());
        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        PostComment postComment = postCommentRepository.findById(commentId)
                .orElseThrow(() -> new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Post comment %d not found", commentId)));

        if(!postComment.getEnigmaUserId().equals(userId)){
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post comment %d", userId, postComment.getId()));
        }

        postCommentRepository.delete(postComment);
    }

    @Override
    public List<PostCommentDto> getPostComments(Long postId, Long userId) {

        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.checkInterestAreaAccess(post.getInterestAreaId(), userId);

        moderationService.assertNotBanned(userId, postId, post.getInterestAreaId());
        checkAgeRestriction(post, enigmaUserRepository.findEnigmaUserById(userId));

        List<PostComment> postComments = postCommentRepository.findByPostId(postId);

        List<Long> userIds = postComments.stream().map(PostComment::getEnigmaUserId).collect(Collectors.toList());

        List<EnigmaUser> enigmaUsers = enigmaUserRepository.findAllById(userIds);


        return postComments.stream().map(
                postComment -> {
                    EnigmaUser enigmaUser = enigmaUsers.stream().filter(user -> user.getId().equals(postComment.getEnigmaUserId())).findFirst().orElse(null);
                    return PostCommentDto.builder()
                            .id(postComment.getId())
                            .postId(postComment.getPostId())
                            .enigmaUser(enigmaUser.mapToEnigmaUserDto())
                            .content(postComment.getContent())
                            .createTime(postComment.getCreateTime())
                            .build();
                }
        ).collect(Collectors.toList());
    }

    /**
     * Deletes all posts of the user
     *
     * @param enigmaUserId EnigmaUser.Id
     */
    @Override
    @Transactional
    public void deleteAllForUser(Long enigmaUserId) {

        try {
            postRepository.findByEnigmaUserId(enigmaUserId).forEach(post -> {
                postCommentRepository.deleteByPostId(post.getId());
                postVoteRepository.deleteByPostId(post.getId());
                interestAreaPostRepository.deleteByPostId(post.getId());
                entityTagsRepository.deleteAll(entityTagsRepository.findByEntityIdInAndEntityType(List.of(post.getId()), EntityType.POST));
                postRepository.deleteById(post.getId());
            });
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_DELETE_ERROR,
                    "Could not delete posts.");
        }

    }


    /**
     * Gets the number of posts of a user
     *
     * @param enigmaUserId  EnigmaUser.Id
     * @return              Integer
     */
    @Override
    public Integer getPostCount(Long enigmaUserId) {

        try {
            return postRepository.countAllByEnigmaUserId(enigmaUserId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch post count.");
        }
    }

    /**
     * Deletes an existing post
     *
     * @param postId    Post.Id
     */
    @Override
    @Transactional
    public void deletePost(Long postId) {

        Post post;
        try {
            post = postRepository.findById(postId).orElse(null);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch post.");
        }

        if (post == null)
            throw new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND,
                    "Post with id " + postId + " does not exist.");

        try {
            postRepository.delete(post);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_DELETE_ERROR,
                    "Could not delete post.");
        }
    }

    /**
     * Gets the interest area id of a post
     *
     * @param postId   Post.Id
     * @return         Integer
     */
    @Override
    public Long getInterestAreaIdOfPost(Long postId) {

        try {
            return postRepository.findInterestAreaIdByPostId(postId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch interest area id of post.");
        }
    }

    /**
     * Gets the user id of a post
     *
     * @param postId   Post.Id
     * @return         Integer
     */
    @Override
    public Long getUserIdOfPost(Long postId) {

        try {
            return postRepository.findEnigmaUserIdByPostId(postId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch user id of post.");
        }
    }

    @Override
    public void checkAgeRestriction(Post post, EnigmaUser user) {
        postServiceHelper.checkAgeRestriction(post, user);
    }
}
