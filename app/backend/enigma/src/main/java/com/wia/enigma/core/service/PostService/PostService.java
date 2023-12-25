package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.PostCommentDto;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.dto.PostVoteDto;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.entity.PostVote;
import com.wia.enigma.dal.enums.PostLabel;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface PostService {

    PostDto getPost(Long postId, Long userId);

    PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink, String title, List<String> wikiTags,
                             PostLabel label, String content, Boolean isAgeRestricted, GeoLocation geolocation);

    PostDtoSimple updatePost(Long userId, Long postId, String sourceLink, String title, List<String> wikiTags, PostLabel label, String content, GeoLocation geolocation);

    void deletePost(Long postId, Long userId);

    void votePost(Long postId, Long userId, Boolean vote);

    List<PostVoteDto> getPostVotes(Long postId, Long userId);

    List<PostDto> getInterestAreaPosts(Long interestAreaId, Long userId);

    List<PostDto> search(Long userId, String searchKey);

    void commentOnPost(Long postId, Long userId, String content);

    void updatePostComment(Long postId, Long userId, Long commentId, String content);

    void deletePostComment(Long postId, Long userId, Long commentId);

    List<PostCommentDto> getPostComments(Long postId, Long userId);

    void deleteAllForUser(Long enigmaUserId);

    Integer getPostCount(Long enigmaUserId);

    @Transactional
    void deletePost(Long postId);

    Long getInterestAreaIdOfPost(Long postId);

    Long getUserIdOfPost(Long postId);

    void checkAgeRestriction(Post post, EnigmaUser user);
}
