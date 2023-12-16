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
    public ResponseEntity<?> getUser(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        EnigmaUserDto enigmaUserDto =  enigmaUserService.getUser(id);
        return ResponseEntity.ok(enigmaUserDto);
    }


    /*
        WA-12: Follows user.
     */
    @GetMapping("follow")
    public ResponseEntity<?> followUser(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        enigmaUserService.followUser(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-13: Unfollows user.
     */
    @GetMapping("unfollow")
    public ResponseEntity<?> unfollowUser(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        enigmaUserService.unfollowUser(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-25: Gets followers.
     */
    @GetMapping("/{id}/followers")
    public ResponseEntity<?> getFollowers(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(enigmaUserService.getFollowers(token.getEnigmaUserId(), id));
    }

    /*
        WA-26: Gets followings.
     */
    @GetMapping("/{id}/followings")
    public ResponseEntity<?> getFollowings(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(enigmaUserService.getFollowings(token.getEnigmaUserId(), id));
    }

    /*
        WA-29: Gets following interest areas.
     */
    @GetMapping("/{id}/interest-areas")
    public ResponseEntity<?> getFollowingInterestAreas(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(enigmaUserService.getFollowingInterestAreas(token.getEnigmaUserId(), id));
    }

    /*
        WA-31: Gets posts.
     */
    @GetMapping("/{id}/posts")
    public ResponseEntity<?> getPosts(@Valid @NotNull @PathVariable(value = "id") Long id, EnigmaAuthenticationToken token) {

        return ResponseEntity.ok(enigmaUserService.getPosts(token.getEnigmaUserId(), id));
    }
}
