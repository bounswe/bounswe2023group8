package com.wia.enigma.core.service.PostService;

import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.model.GeoLocation;
import com.wia.enigma.dal.enums.PostLabel;

import java.util.List;

public interface PostService {

    PostDto getPost(Long postId, Long userId);
    PostDtoSimple createPost(Long userId, Long interestAreaId, String sourceLink, String title, List<String> wikiTags, PostLabel label, GeoLocation geolocation);

    PostDtoSimple updatePost(Long userId, Long postId, String sourceLink, String title, List<String> wikiTags, PostLabel label, GeoLocation geolocation);

    void deletePost(Long postId, Long userId);
}
