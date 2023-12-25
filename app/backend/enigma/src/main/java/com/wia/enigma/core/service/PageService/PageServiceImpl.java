package com.wia.enigma.core.service.PageService;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.data.model.InterestAreaModel;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.repository.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PageServiceImpl implements PageService{
    private final PostCommentRepository postCommentRepository;
    private final PostVoteRepository postVoteRepository;
    private final NestedInterestAreaRepository nestedInterestAreaRepository;
    final EnigmaUserRepository enigmaUserRepository;
    final InterestAreaRepository interestAreaRepository;
    final PostRepository postRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final EntityTagsRepository entityTagRepository;
    final WikiTagRepository wikiTagRepository;

    final EnigmaUserService enigmaUserService;
    final PostService postService;

    public ProfilePageDto getProfilePage(Long userId, Long profileId) {

        EnigmaUserDto enigmaUserDto = enigmaUserService.getVerifiedUser(profileId);
        Pair<Integer, Integer> votes = enigmaUserService.getVotes(profileId);

        return ProfilePageDto.builder()
                .id(enigmaUserDto.getId())
                .username(enigmaUserDto.getUsername())
                .name(enigmaUserDto.getName())
                .birthday(enigmaUserDto.getBirthday())
                .followers(enigmaUserService.getFollowerCount(profileId))
                .following(enigmaUserService.getFollowingCount(profileId))
                .pictureUrl(enigmaUserDto.getPictureUrl())
                .upvotes(votes.getFirst())
                .downvotes(votes.getSecond())
                .build();
    }

    public HomePageDto getHomePage(Long userId) {

        return HomePageDto.builder()
                .posts(getPosts(userId))
                .build();
    }


    private List<PostDto> getPosts(Long userId) {

        EnigmaUser user = enigmaUserRepository.findById(userId).orElseThrow(() -> new RuntimeException("User not found"));

        // Collect the initial stream to a list to reuse it
        List<Long> followedInterestAreaIdList = enigmaUserService.getFollowingInterestAreas(userId, userId).stream()
                .map(InterestAreaDto::getId)
                .collect(Collectors.toList());

        // Use the list to create a stream for nestedFollowedInterestAreaIds
        Stream<Long> nestedFollowedInterestAreaIds = nestedInterestAreaRepository.findByParentInterestAreaIdIn(followedInterestAreaIdList)
                .stream()
                .map(nestedInterestArea -> nestedInterestArea.getChildInterestAreaId());

        // Concatenate and collect
        List<Long> allRelatedInterestAreaIds =  Stream.concat(followedInterestAreaIdList.stream(), nestedFollowedInterestAreaIds)
                .collect(Collectors.toList());

        List<Long> followedEnigmaUserIds = enigmaUserService.getFollowings(userId, userId).stream( )
                .map(EnigmaUserDto::getId).collect(Collectors.toList());

        List<Long> followedInterestAreaPostIds = interestAreaPostRepository.findByInterestAreaIdIn(allRelatedInterestAreaIds)
                .stream().map(InterestAreaPost::getPostId).collect(Collectors.toList());

        List<Post> posts = postRepository.findByEnigmaUserIdInOrPostIdIn(followedEnigmaUserIds, followedInterestAreaPostIds);

        List<Long> postInterestAreaIds = posts.stream().map(Post::getInterestAreaId).collect(Collectors.toList());

        List<Long> postEnigmaUserIds = posts.stream().map(Post::getEnigmaUserId).collect(Collectors.toList());

        List<InterestAreaModel> interestAreaModels =  interestAreaRepository.findAllByIdIn(postInterestAreaIds).stream()
                .map(InterestArea::mapToInterestAreaModel)
                .toList();

        List<EnigmaUserDto> enigmaUserDtos = enigmaUserRepository.findByIdIn(postEnigmaUserIds).stream().map(EnigmaUser::mapToEnigmaUserDto)
                .toList();

        List<EntityTag> entityTags = entityTagRepository.findByEntityIdInAndEntityType(posts.stream()
                .map(Post::getId).toList(), EntityType.POST);

        List<String> wikiTagIds = entityTags.stream().map(EntityTag::getWikiDataTagId).toList();

        List<WikiTag> wikiTags = wikiTagRepository.findByIdIn(wikiTagIds);

        return posts.stream().map(post -> {

            try {
                postService.checkAgeRestriction(post, user);
            } catch (Exception e) {
                return null;
            }

            return post.mapToPostDto(
                    entityTags.stream().filter(entityTag -> entityTag.getEntityId().equals(post.getId())).map(
                            entityTag -> wikiTags.stream().filter(wikiTag -> wikiTag.getId().equals(entityTag.getWikiDataTagId())).findFirst().orElse(null)
                    ).collect(Collectors.toList()),
                    enigmaUserDtos.stream().filter(enigmaUserDto -> enigmaUserDto.getId().equals(post.getEnigmaUserId())).findFirst().orElse(null),
                    interestAreaModels.stream().filter(interestAreaModel -> interestAreaModel.getId().equals(post.getInterestAreaId())).findFirst().orElse(null),
                    postVoteRepository.countByPostIdAndVote(post.getId(), true),
                    postVoteRepository.countByPostIdAndVote(post.getId(), false),
                    postCommentRepository.countByPostId(post.getId())
            );
        }).filter(Objects::nonNull).collect(Collectors.toList());
    }

    public ExplorePageDto getExplorePage() {

        return ExplorePageDto.builder()
                .posts(getPublicPosts(20L))
                .interestAreas(getInterestAreas(5L))
                .enigmaUsers(getEnigmaUsers(5L))
                .build();
    }


    private List<PostDto> getPublicPosts(Long postCount){

        List<Post> posts = postRepository.findByAccessLevelOrderByCreateTimeDesc(EnigmaAccessLevel.PUBLIC);

        posts = posts.subList(0, Math.min(posts.size(), postCount.intValue()));

        List<EnigmaUserDto> enigmaUserDtos = enigmaUserRepository.findByIdIn(posts.stream().map(Post::getEnigmaUserId).toList()).stream().map(EnigmaUser::mapToEnigmaUserDto).toList();

        List<EntityTag> entityTags = entityTagRepository.findByEntityIdInAndEntityType(posts.stream().map(Post::getId).toList(), EntityType.POST);

        List<String> wikiTagIds = entityTags.stream()
                .map(EntityTag::getWikiDataTagId).toList();

        List<InterestAreaModel> interestAreaModels =  interestAreaRepository.findAllByIdIn(posts.stream().map(Post::getInterestAreaId).toList()).stream()
                .map(InterestArea::mapToInterestAreaModel)
                .toList();

        List<WikiTag> wikiTags = wikiTagRepository.findByIdIn(wikiTagIds);

        List<PostDto> publicPosts = posts.stream().map(post -> {

            if(post.getIsAgeRestricted() != null && post.getIsAgeRestricted()){

                return null;
            }

            return post.mapToPostDto(
                    entityTags.stream().filter(entityTag -> entityTag.getEntityId().equals(post.getId())).map(
                            entityTag -> wikiTags.stream().filter(wikiTag -> wikiTag.getId().equals(entityTag.getWikiDataTagId())).findFirst().orElse(null)
                    ).collect(Collectors.toList()),
                    enigmaUserDtos.stream().filter(enigmaUserDto -> enigmaUserDto.getId().equals(post.getEnigmaUserId())).findFirst().orElse(null),
                    interestAreaModels.stream().filter(interestAreaModel -> interestAreaModel.getId().equals(post.getInterestAreaId())).findFirst().orElse(null),
                    postVoteRepository.countByPostIdAndVote(post.getId(), true),
                    postVoteRepository.countByPostIdAndVote(post.getId(), false),
                    postCommentRepository.countByPostId(post.getId())
            );
        }).filter(Objects::nonNull).collect(Collectors.toList());

        return publicPosts;

    }

    private List<InterestAreaDto> getInterestAreas(Long interestAreaCount){

        List<InterestArea> interestAreas = interestAreaRepository.findByAccessLevelInOrderByCreateTimeDesc(List.of(EnigmaAccessLevel.PUBLIC, EnigmaAccessLevel.PRIVATE));

        interestAreas = interestAreas.subList(0, Math.min(interestAreas.size(), interestAreaCount.intValue()));

        List<EntityTag> entityTags = entityTagRepository.findByEntityIdInAndEntityType(interestAreas.stream().map(InterestArea::getId).toList(), EntityType.INTEREST_AREA);
        List<String> wikiTagIds = entityTags.stream().map(EntityTag::getWikiDataTagId).toList();
        List<WikiTag> wikiTags = wikiTagRepository.findByIdIn(wikiTagIds);

        return interestAreas.stream().map(interestArea -> interestArea.mapToInterestAreaDto(
                entityTags.stream().filter(entityTag -> entityTag.getEntityId().equals(interestArea.getId())).map(
                        entityTag -> wikiTags.stream().filter(wikiTag -> wikiTag.getId().equals(entityTag.getWikiDataTagId())).findFirst().orElse(null)
                ).collect(Collectors.toList())
        )).collect(Collectors.toList());
    }

    private List<EnigmaUserDto> getEnigmaUsers(Long enigmaUserCount){

        List<EnigmaUser> enigmaUsers = enigmaUserRepository.findAll();

        enigmaUsers = enigmaUsers.subList(0, Math.min(enigmaUsers.size(), enigmaUserCount.intValue()));

        return enigmaUsers.stream().map(EnigmaUser::mapToEnigmaUserDto).collect(Collectors.toList());
    }
}
