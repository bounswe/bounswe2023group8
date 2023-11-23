package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.core.service.WikiService.WikiService;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.entity.InterestAreaPost;
import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.PostLabel;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import com.wia.enigma.dal.repository.PostRepository;
import com.wia.enigma.dal.repository.WikiTagRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostServiceImpl implements PostService{
    private final WikiTagRepository wikiTagRepository;
    private final EnigmaUserRepository enigmaUserRepository;

    final PostRepository postRepository;
    final PostServiceHelper postServiceHelper;
    final WikiService wikiTagService;

    @Override
    public PostDto getPost(Long postId, Long userId) {
        Post post = postServiceHelper.fetchPost(postId);
        postServiceHelper.validateUserFollowsInterestArea(userId, post);

        List<WikiTag> wikiTags = postServiceHelper.getWikiTags(postId);

        EnigmaUser enigmaUser= enigmaUserRepository.findEnigmaUserById(post.getEnigmaUserId());

        if(enigmaUser == null){
            throw new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND, String.format("Enigma user %d not found", post.getEnigmaUserId()));
        }

        return post.mapToPostDto(wikiTags, enigmaUser.mapToEnigmaUserDto() );
    }

    @Override
    @Transactional
    public PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink,
                                    String title, List<String> wikiTags, PostLabel label, String content,
                                    GeoLocation geolocation) {

        postServiceHelper.validateInterestAreaAndUserFollowing(interestAreaId, userId);
        Post post = postServiceHelper.createAndSavePost(userId, interestAreaId, sourceLink, title, label, content, geolocation);

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

        if(post.getEnigmaUserId() != userId){
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION, String.format("User %d is not the owner of post %d", userId, post.getId()));
        }

        postRepository.delete(post);
    }

    @Override
    public List<PostDto> getInterestAreaPosts(Long interestAreaId, Long userId) {

       return postServiceHelper.getInterestAreaPosts(interestAreaId, userId );
    }
}
