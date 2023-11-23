package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.request.CreatePostRequest;
import com.wia.enigma.core.data.request.UpdatePostRequest;
import com.wia.enigma.core.service.PostService.PostService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostController {

    final PostService postService;


    @GetMapping()
    public ResponseEntity<?> getPost(@RequestParam Long id, EnigmaAuthenticationToken token){

        PostDto postDto = postService.getPost(id, token.getEnigmaUserId());

        return ResponseEntity.ok(postDto);
    }

    @PostMapping()
    public ResponseEntity<?> createPost(@RequestBody @Valid @NotNull CreatePostRequest createPostRequest, EnigmaAuthenticationToken token){

        PostDtoSimple postDtoSimple = postService.createPost(
                token.getEnigmaUserId(),
                createPostRequest.getInterestAreaId(),
                createPostRequest.getSourceLink(),
                createPostRequest.getTitle(),
                createPostRequest.getWikiTags(),
                createPostRequest.getLabel(),
                createPostRequest.getContent(),
                createPostRequest.getGeoLocation()
        );

        return ResponseEntity.ok(postDtoSimple);
    }

    @PutMapping()
    public ResponseEntity<?> updatePost(@RequestParam Long id,  @RequestBody @Valid @NotNull UpdatePostRequest updatePostRequest, EnigmaAuthenticationToken token){

        PostDtoSimple postDtoSimple = postService.updatePost(
                token.getEnigmaUserId(),
                id,
                updatePostRequest.getSourceLink(),
                updatePostRequest.getTitle(),
                updatePostRequest.getWikiTags(),
                updatePostRequest.getLabel(),
                updatePostRequest.getContent(),
                updatePostRequest.getGeoLocation()
        );

        return ResponseEntity.ok(postDtoSimple);
    }

    @DeleteMapping()
    public ResponseEntity<?> deletePost(@RequestParam Long id, EnigmaAuthenticationToken token){

        postService.deletePost(id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }
}
