package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.request.CreateInterestAreaRequest;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.PostService.PostService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/interest-area")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaController {

    final InterestAreaService interestAreaService;
    final PostService postService;

    /*
        WA-8: Gets interest areas.
     */
    @GetMapping()
    public ResponseEntity<?> getInterestArea(@Valid  @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token ) {

        InterestAreaDto interestAreaDto = interestAreaService.getInterestArea(id,  token.getEnigmaUserId());

        return ResponseEntity.ok(interestAreaDto);

    }

    /*
        WA-9: Creates interest area.
     */
    @PostMapping()
    public ResponseEntity<?> createInterestArea(@RequestBody @Valid @NotNull CreateInterestAreaRequest createInterestAreaRequest, EnigmaAuthenticationToken token) {

        InterestAreaSimpleDto interestAreaSimpleDto = interestAreaService.createInterestArea(
                token.getEnigmaUserId(),
                createInterestAreaRequest.getTitle(),
                createInterestAreaRequest.getDescription(),
                createInterestAreaRequest.getAccessLevel(),
                createInterestAreaRequest.getNestedInterestAreas(),
                createInterestAreaRequest.getWikiTags()
        );

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/api/v1/interest-area/{id}")
                                .buildAndExpand(interestAreaSimpleDto.getId())
                                .toUri()
                )
                .body(interestAreaSimpleDto);
    }

    /*
        WA-10: Updates interest area.
     */
    @PutMapping()
    public ResponseEntity<?> updateInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, @RequestBody @Valid @NotNull CreateInterestAreaRequest createInterestAreaRequest) {

        InterestAreaSimpleDto interestAreaSimpleDto = interestAreaService.updateInterestArea(
                id,
                createInterestAreaRequest.getTitle(),
                createInterestAreaRequest.getDescription(),
                createInterestAreaRequest.getAccessLevel(),
                createInterestAreaRequest.getNestedInterestAreas(),
                createInterestAreaRequest.getWikiTags()
        );

        return ResponseEntity.ok(interestAreaSimpleDto);

    }

    /*
        WA-11: Deletes interest area.
     */
    @DeleteMapping()
    public ResponseEntity<?> deleteInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id) {

        interestAreaService.deleteInterestArea(id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-14: Follows interest area.
     */
    @GetMapping("follow")
    public ResponseEntity<?> followInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.followInterestArea(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-15: Unfollows interest area.
     */
    @GetMapping("unfollow")
    public ResponseEntity<?> unfollowInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.unfollowInterestArea(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-27: Gets followers.
     */
    @GetMapping("/{id}/followers")
    public ResponseEntity<?> getFollowers(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(interestAreaService.getFollowers(token.getEnigmaUserId(), id));
    }

    /*
        WA-28: Gets posts.
     */
    @GetMapping("/{id}/posts")
    public ResponseEntity<?> getPosts(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(postService.getInterestAreaPosts(id, token.getEnigmaUserId()));
    }

    /*
        WA-30: Gets nested interest areas.
     */
    @GetMapping("/{id}/nested-interest-areas")
    public ResponseEntity<?> getNestedInterestAreas(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(interestAreaService.getNestedInterestAreas(id, token.getEnigmaUserId()));
    }


    /*
        WA-17: Searches interest areas.
     */
    @GetMapping("/search")
    public ResponseEntity<?>  searchInterestArea(@Valid @NotNull @RequestParam(name = "searchKey") String searchKey,  EnigmaAuthenticationToken token) {

        List<InterestAreaSimpleDto> search = interestAreaService.search(token.getEnigmaUserId(), searchKey);

        return ResponseEntity.ok(search);
    }

    /*
        WA-38: Get follow requests
     */
    @GetMapping("/{id}/follow-requests")
    public ResponseEntity<?> getFollowRequests(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(interestAreaService.getFollowRequests(token.getEnigmaUserId(), id));
    }

    /*
        WA-39: Accept follow request
     */
    @GetMapping("/accept-follow-request")
    public ResponseEntity<?> acceptFollowRequest(@Valid @NotNull @RequestParam(name = "requestId") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.acceptFollowRequest(id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    /*
        WA-40: Reject follow request
     */
    @GetMapping("/reject-follow-request")
    public ResponseEntity<?> rejectFollowRequest(@Valid @NotNull @RequestParam(name = "requestId") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.rejectFollowRequest(id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    /*
        WA-55: Upload interest area picture
     */
    @PostMapping("/{id}/upload-picture")
    public ResponseEntity<?> uploadInterestAreaPicture(@Valid @NotNull @PathVariable(name = "id") Long id,
                                                       @RequestParam("image") MultipartFile image,
                                                       EnigmaAuthenticationToken token) {

        interestAreaService.uploadInterestAreaPicture(image, id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    /*
        WA-56: Delete interest area picture
     */
    @DeleteMapping("/{id}/delete-picture")
    public ResponseEntity<?> deleteInterestAreaPicture(@Valid @NotNull @PathVariable(name = "id") Long id,
                                                       EnigmaAuthenticationToken token) {

        interestAreaService.deleteInterestAreaPicture(id, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }
}
