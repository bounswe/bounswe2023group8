package com.wia.enigma.core.service.PageService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.ProfilePageDto;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PageServiceImpl implements PageService{

    final EnigmaUserService enigmaUserService;

    public ProfilePageDto getProfilePage(Long userId, Long profileId) {

        EnigmaUserDto enigmaUserDto = enigmaUserService.getVerifiedUser(profileId);

        ProfilePageDto profilePageDto = ProfilePageDto.builder()

                .id(enigmaUserDto.getId())
                .username(enigmaUserDto.getUsername())
                .birthday(enigmaUserDto.getBirthday())
                .followers(enigmaUserService.getFollowers(userId, profileId))
                .following(enigmaUserService.getFollowings(userId, profileId))
                .interestAreas(enigmaUserService.getFollowingInterestAreas(userId, profileId))
                .posts(Collections.emptyList())
                .build();

        return profilePageDto;
    }
}