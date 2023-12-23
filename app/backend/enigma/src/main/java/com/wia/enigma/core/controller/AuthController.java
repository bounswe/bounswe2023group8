package com.wia.enigma.core.controller;


import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.request.ChangePasswordRequest;
import com.wia.enigma.core.data.request.SignupRequest;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/auth")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthController {

    final EnigmaUserService enigmaUserService;

    /**
     * WA-1: Signs up a new user.
     */
    @PostMapping("/signup")
    public ResponseEntity<?> signup(@Valid @RequestBody SignupRequest signupRequest) {

        RegisterResponse registerResponse = enigmaUserService.registerEnigmaUser(
                signupRequest.getUsername(),
                signupRequest.getName(),
                signupRequest.getEmail(),
                signupRequest.getPassword(),
                signupRequest.getBirthday()
        );

        if (registerResponse == null)
            return ResponseEntity
                    .status(HttpStatus.UNAUTHORIZED)
                    .build();

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/api/v1/user/{enigmaUserId}")
                                .buildAndExpand(registerResponse.getEnigmaUserId())
                                .toUri()
                )
                .body(registerResponse);
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

    /**
     *   WA-59: Changes a user's password.
     */
    @PostMapping("/change-password")
    public ResponseEntity<?> changePassword(@NotNull @RequestParam Long enigmaUserId,
                                            @Valid @NotNull @RequestBody ChangePasswordRequest changePasswordRequest) {

        enigmaUserService.changePassword(
                enigmaUserId,
                changePasswordRequest.getOldPassword(),
                changePasswordRequest.getNewPassword1(),
                changePasswordRequest.getNewPassword2()
        );

        return ResponseEntity
                .status(HttpStatus.OK)
                .build();
    }
}
