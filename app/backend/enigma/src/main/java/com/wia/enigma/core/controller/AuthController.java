package com.wia.enigma.core.controller;


import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.configuration.security.EnigmaUserDetailsService;
import com.wia.enigma.core.data.request.SignupRequest;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.core.service.EnigmaJwtService;
import com.wia.enigma.core.service.EnigmaUserService;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import com.wia.enigma.exceptions.custom.EnigmaUnauthorizedException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.apache.coyote.Response;
import org.springframework.data.util.Pair;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthController {

    final EnigmaUserService enigmaUserService;

    /**
     * WA-1: Signs up a new user.
     */
    @PostMapping("/signup")
    public ResponseEntity<?> signup(@Valid @RequestBody SignupRequest signupRequest) {

        enigmaUserService.registerEnigmaUser(
                signupRequest.getUsername(),
                signupRequest.getEmail(),
                signupRequest.getPassword(),
                signupRequest.getBirthday()
        );

        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }

    /**
     * WA-2: Signs in a user.
     */
    @GetMapping("/signin")
    public ResponseEntity<?> signin(@Valid @NotNull @RequestParam(name = "user") String usernameOrEmail,
                                    @Valid @NotNull @RequestParam String password) {

        LoginResponse loginResponse = enigmaUserService.loginEnigmaUser(usernameOrEmail, password);

        if (loginResponse == null)
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .build();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(loginResponse);
    }

    /**
     * WA-3: Signs out a user.
     */
    @PostMapping("/logout")
    public ResponseEntity<?> logout(HttpServletRequest request) {

        enigmaUserService.logoutEnigmaUser(request.getHeader(HttpHeaders.AUTHORIZATION));

        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }

    /**
     * WA-4: Verifies a user.
     */
    @GetMapping("/verify")
    public ResponseEntity<?> verify(@Valid @NotNull @RequestParam(name = "token") String token) {

        VerificationResponse verifiedEnigmaUserId = enigmaUserService.verifyEnigmaUser(token);

        if (verifiedEnigmaUserId == null)
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .build();

        return ResponseEntity
                .status(HttpStatus.OK)
                .body(verifiedEnigmaUserId);
    }

    /**
     * WA-5: Sends a password reset email.
     */
    @GetMapping("/forgot-password")
    public ResponseEntity<?> forgotPassword(@Valid @NotNull @RequestParam(name = "email") String email) {

        enigmaUserService.forgotPassword(email);

        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }

    /**
     * WA-6: Resets a user's password.
     */
    @GetMapping("/reset-password")
    public ResponseEntity<?> resetPassword(@Valid @NotNull @RequestParam(name = "token") String token,
                                           @Valid @NotNull @RequestParam(name = "password1") String password1,
                                           @Valid @NotNull @RequestParam(name = "password2") String password2 ) {

        enigmaUserService.resetPassword(token, password1, password2);

        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }
}
