package com.bounswe.group8.mapper;

import com.bounswe.group8.model.User;
import com.bounswe.group8.payload.dto.UserDto;

import java.util.Collections;

public class UserMapper {

    public static UserDto userToUserDto(User user) {
        return new UserDto()
                .setId(user.getId())
                .setUsername(user.getUsername())
                .setPosts(user.getPosts() == null ?
                        Collections.emptyList() :
                        user.getPosts()
                                .stream()
                                .map(PostMapper::postToPostDto)
                                .toList()
                );
    }

}
