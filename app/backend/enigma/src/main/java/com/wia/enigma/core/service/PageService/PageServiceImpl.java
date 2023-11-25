package com.wia.enigma.core.service.PageService;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.data.model.InterestAreaModel;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.repository.*;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import javax.swing.text.html.parser.Entity;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PageServiceImpl implements PageService{
    final EnigmaUserRepository enigmaUserRepository;
    final InterestAreaRepository interestAreaRepository;
    final PostRepository postRepository;
    final InterestAreaPostRepository interestAreaPostRepository;
    final EntityTagsRepository entityTagRepository;
    final WikiTagRepository wikiTagRepository;

    final EnigmaUserService enigmaUserService;
    final InterestAreaService interestAreaService;

    public ProfilePageDto getProfilePage(Long userId, Long profileId) {

        EnigmaUserDto enigmaUserDto = enigmaUserService.getVerifiedUser(profileId);

        ProfilePageDto profilePageDto = ProfilePageDto.builder()

                .id(enigmaUserDto.getId())
                .username(enigmaUserDto.getUsername())
                .name(enigmaUserDto.getName())
                .birthday(enigmaUserDto.getBirthday())
                .followers(enigmaUserService.getFollowerCount(profileId))
                .following(enigmaUserService.getFollowingCount(profileId))
                .build();

        return profilePageDto;
    }

    public HomePageDto getHomePage(Long userId) {

        HomePageDto homePageDto = HomePageDto.builder()

                .posts(getPosts(userId))
                .build();
        return homePageDto;
    }


    private List<PostDto> getPosts(Long userId) {

        List<Long> followedInterestAreaIds = enigmaUserService.getFollowingInterestAreas(userId, userId).stream()
                .map(InterestAreaDto::getId).collect(Collectors.toList());


        List<Long> followedEnigmaUserIds = enigmaUserService.getFollowings(userId, userId).stream( )
                .map(EnigmaUserDto::getId).collect(Collectors.toList());

        System.out.println("patladı");

        List<Long> followedInterestAreaPostIds = interestAreaPostRepository.findByInterestAreaIdIn(followedInterestAreaIds)
                .stream().map(InterestAreaPost::getPostId).collect(Collectors.toList());

        System.out.println("patladı2");

        List<Post> posts = postRepository.findByEnigmaUserIdInOrPostIdIn(followedEnigmaUserIds, followedInterestAreaPostIds);

        System.out.println("patladı3");

        List<Long> postInterestAreaIds = posts.stream().map(Post::getInterestAreaId).collect(Collectors.toList());

        List<Long> postEnigmaUserIds = posts.stream().map(Post::getEnigmaUserId).collect(Collectors.toList());

        List<InterestAreaModel> interestAreaModels =  interestAreaRepository.findAllByIdIn(postInterestAreaIds).stream()
                .map(interestArea -> interestArea.mapToInterestAreaModel())
                .collect(Collectors.toList());

        List<EnigmaUserDto> enigmaUserDtos = enigmaUserRepository.findByIdIn(postEnigmaUserIds).stream().map(enigmaUser -> enigmaUser.mapToEnigmaUserDto())
                .collect(Collectors.toList());

        List<EntityTag> entityTags = entityTagRepository.findByEntityIdInAndEntityType(posts.stream()
                .map(post -> post.getId()).toList(), EntityType.POST);

        List<String> wikiTagIds = entityTags.stream().map(entityTag -> entityTag.getWikiDataTagId()).toList();

        List<WikiTag> wikiTags = wikiTagRepository.findByIdIn(wikiTagIds);

        return posts.stream().map(post ->
                post.mapToPostDto(
                        entityTags.stream().filter(entityTag -> entityTag.getEntityId().equals(post.getId())).map(
                                entityTag -> wikiTags.stream().filter(wikiTag -> wikiTag.getId().equals(entityTag.getWikiDataTagId())).findFirst().orElse(null)
                        ).collect(Collectors.toList()),
                        enigmaUserDtos.stream().filter(enigmaUserDto -> enigmaUserDto.getId().equals(post.getEnigmaUserId())).findFirst().orElse(null),
                        interestAreaModels.stream().filter(interestAreaModel -> interestAreaModel.getId().equals(post.getInterestAreaId())).findFirst().orElse(null)
                )).toList();





    }
}