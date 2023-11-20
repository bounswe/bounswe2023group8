package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
}
