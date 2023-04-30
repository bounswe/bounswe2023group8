package com.bounswe.group8.mapper;

import com.bounswe.group8.model.Post;
import com.bounswe.group8.payload.dto.PostDto;

public class PostMapper {

    public static PostDto postToPostDto(Post post) {
        return new PostDto()
                .setId(post.getId())
                .setTitle(post.getTitle())
                .setContent(post.getContent())
                .setDate(post.getDate())
                .setUserId(post.getUser().getId());
    }

}
