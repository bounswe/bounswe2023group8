package com.bounswe.group8.controller;

import com.bounswe.group8.payload.PostCreateRequest;
import com.bounswe.group8.payload.dto.PostDto;
import com.bounswe.group8.service.PostService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;


@RestController
@RequestMapping("/api/post")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostController {

    final PostService postService;

    /*
     *  WARN: This endpoint is for testing purposes only.
     */
    @GetMapping("/all")
    public ResponseEntity<List<PostDto>> getAllPosts() {
        return ResponseEntity.ok(
                postService.getAll()
        );
    }

    /**
     * P1: Gets posts with pagination.
     *
     * @param page      Page number. Starts at 0. Is the only required parameter.
     * @param size      Number of elements per page. Default value is 10.
     * @param sortBy    Field to sort by. Default value is "id".
     * @param desc      Sort direction. Default value is "false".
     * @return          List of posts in the page
     */
    @GetMapping
    public ResponseEntity<List<PostDto>> getPostPage(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10", required = false) Integer size,
            @RequestParam(defaultValue = "id", required = false) String sortBy,
            @RequestParam(defaultValue = "false", required = false) Boolean desc) {

        List<PostDto> postPage = postService.getPostPage(page, size, sortBy, desc);

        if (postPage.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok().body(postPage);
    }

    /**
     * P2: Get a post by id.
     *
     * @param id    Post id
     * @return      PostDto
     */
    @GetMapping("/{id}")
    public ResponseEntity<PostDto> getPostById(
            @PathVariable Long id) {

        PostDto postDto = postService.getPostById(id);

        if (postDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(postDto);
    }

    /**
     * P3-1: Create a post.
     *
     * @param postCreateRequest     create request
     * @return                      PostDto - created post
     */
    //asfdsa
    @PostMapping
    public ResponseEntity<PostDto> createPost(
            @RequestBody PostCreateRequest postCreateRequest) {

        Long postId = postService.createPost(postCreateRequest);

        if (postId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(postId)
                        .toUri())
                .build();
    }

    /**
     * P3-2: Create a post.
     *
     * @param title     title of the post
     * @param content   content of the post
     * @param userId    id of the user who creates the post
     * @return          PostDto - created post
     */
    @PostMapping("/user/{userId}")
    public ResponseEntity<PostDto> createPost(
            @RequestParam String title,
            @RequestParam String content,
            @PathVariable Long userId){

        Long postId = postService.createPost(title, content, userId);

        if (postId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(postId)
                        .toUri())
                .build();
    }

    /**
     * P4: Update a post.
     *
     * @param id        id of the post to be updated
     * @param title     new title of the post
     * @param content   new content of the post
     * @return          PostDto - updated post
     */
    @PutMapping("/{id}")
    public ResponseEntity<PostDto> updatePost(
            @PathVariable Long id,
            @RequestParam String title,
            @RequestParam String content) {

        PostDto postDto = postService.updatePostById(id, title, content);

        if (postDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(postDto);
    }

    /**
     * P5: Delete a post.
     *
     * @param id    id of the post to be deleted
     * @return      PostDto - deleted post
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<PostDto> deletePost(
            @PathVariable Long id) {

        PostDto postDto = postService.deletePostById(id);

        if (postDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(postDto);
    }

}
