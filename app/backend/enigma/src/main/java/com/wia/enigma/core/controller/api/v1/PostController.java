package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.dto.PostDtoSimple;
import com.wia.enigma.core.data.dto.PostVoteDto;
import com.wia.enigma.core.data.request.CreatePostRequest;
import com.wia.enigma.core.data.request.UpdatePostRequest;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.dal.entity.PostVote;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/post")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PostController {

    final PostService postService;

    /*
        WA-20: Get post.
     */
    @GetMapping()
    public ResponseEntity<?> getPost(@RequestParam Long id, EnigmaAuthenticationToken token){

        PostDto postDto = postService.getPost(id, token.getEnigmaUserId());

        return ResponseEntity.ok(postDto);
    }

    /*
        WA-21: Create post.
     */
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

    /*
        WA-22: Update post.
     */
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

    /*
        WA-23: Delete post.
     */
    @DeleteMapping()
    public ResponseEntity<?> deletePost(@RequestParam Long id, EnigmaAuthenticationToken token){

        postService.deletePost(id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    /*
        WA-34: Upvote post.
     */
    @GetMapping("upvote")
    public ResponseEntity<?> upvotePost(@RequestParam Long id, EnigmaAuthenticationToken token){

        postService.votePost(id, token.getEnigmaUserId(), true);

        return ResponseEntity.ok().build();
    }

    /*
        WA-35: Downvote post.
     */
    @GetMapping("downvote")
    public ResponseEntity<?> downvotePost(@RequestParam Long id, EnigmaAuthenticationToken token){

        postService.votePost(id, token.getEnigmaUserId(), false);

        return ResponseEntity.ok().build();
    }

    /*
        WA-36: Unvote post.
     */
    @GetMapping("unvote")
    public ResponseEntity<?> unvotePost(@RequestParam Long id, EnigmaAuthenticationToken token){

        postService.votePost(id, token.getEnigmaUserId(), null);

        return ResponseEntity.ok().build();
    }

    /*
        WA-37: Get votes.
     */
    @GetMapping("/{id}/votes")
    public ResponseEntity<?> getVotes(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token){

        List<PostVoteDto> postVotes = postService.getPostVotes(id, token.getEnigmaUserId());

        return ResponseEntity.ok(postVotes);
    }
}
