package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserController {

    final EnigmaUserService enigmaUserService;

    @GetMapping("/test")
    public ResponseEntity<?> test(EnigmaAuthenticationToken token) {
        log.info("token: {}", token);

        return ResponseEntity.ok().build();
    }

    /*
        WA-24: Gets user.
     */
    @GetMapping()
    public ResponseEntity<?> getUser(EnigmaAuthenticationToken token,
                                     @Valid @NotNull @RequestParam(name = "id") Long id) {

        EnigmaUserDto enigmaUserDto =  enigmaUserService.getUser(id);

        return ResponseEntity.ok(enigmaUserDto);
    }


    /*
        WA-12: Follows user.
     */
    @GetMapping("follow")
    public ResponseEntity<?> followUser(EnigmaAuthenticationToken token,
                                        @Valid @NotNull @RequestParam(name = "id") Long id) {

        enigmaUserService.followUser(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-13: Unfollows user.
     */
    @GetMapping("unfollow")
    public ResponseEntity<?> unfollowUser(EnigmaAuthenticationToken token,
                                          @Valid @NotNull @RequestParam(name = "id") Long id) {

        enigmaUserService.unfollowUser(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-25: Gets followers.
     */
    @GetMapping("/{id}/followers")
    public ResponseEntity<?> getFollowers(EnigmaAuthenticationToken token,
                                          @Valid @NotNull @PathVariable(value = "id") Long id) {

        return ResponseEntity.ok(enigmaUserService.getFollowers(token.getEnigmaUserId(), id));
    }

    /*
        WA-26: Gets followings.
     */
    @GetMapping("/{id}/followings")
    public ResponseEntity<?> getFollowings(EnigmaAuthenticationToken token,
                                           @Valid @NotNull @PathVariable(value = "id") Long id) {

        return ResponseEntity.ok(enigmaUserService.getFollowings(token.getEnigmaUserId(), id));
    }

    /*
        WA-29: Gets following interest areas.
     */
    @GetMapping("/{id}/interest-areas")
    public ResponseEntity<?> getFollowingInterestAreas(EnigmaAuthenticationToken token,
                                                       @Valid @NotNull @PathVariable(value = "id") Long id) {

        return ResponseEntity.ok(enigmaUserService.getFollowingInterestAreas(token.getEnigmaUserId(), id));
    }

    /*
        WA-60: Gets interest area follow requests.
     */
    @GetMapping("/interest-area-follow-requests")
    public ResponseEntity<?> getInterestAreaFollowRequests(EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(enigmaUserService.getInterestAreaFollowRequests(token.getEnigmaUserId()));
    }

    /*
        WA-31: Gets posts.
     */
    @GetMapping("/{id}/posts")
    public ResponseEntity<?> getPosts(EnigmaAuthenticationToken token,
                                      @Valid @NotNull @PathVariable(value = "id") Long id) {

        return ResponseEntity.ok(enigmaUserService.getPosts(token.getEnigmaUserId(), id));
    }

    /*
        WA-33: Deletes user
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<?> deleteUser(EnigmaAuthenticationToken token,
                                        @Valid @NotNull @PathVariable Long id) {

        enigmaUserService.deleteUser(id);

        return ResponseEntity.noContent().build();
    }

    /*
        WA-57: Upload profile picture
     */
    @PostMapping("/upload-picture")
    public ResponseEntity<?> uploadProfilePicture(EnigmaAuthenticationToken token,
                                           @Valid @NotNull @RequestParam(name = "image") MultipartFile file) {

        enigmaUserService.uploadProfilePicture(token.getEnigmaUserId(), file);

        return ResponseEntity.ok().build();
    }

    /*
        WA-58: Delete profile picture
     */
    @DeleteMapping("/delete-picture")
    public ResponseEntity<?> deleteProfilePicture(EnigmaAuthenticationToken token) {

        enigmaUserService.deleteProfilePicture(token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

}
