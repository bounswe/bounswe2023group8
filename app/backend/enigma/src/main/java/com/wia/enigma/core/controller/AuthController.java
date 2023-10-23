package com.wia.enigma.core.controller;


import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.apache.coyote.Response;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthController {

    @GetMapping("/login")
    public ResponseEntity<?> login(@RequestParam String usernameInfo,
                                   @RequestParam String password) {

        return ResponseEntity.ok().build();
    }


    @GetMapping("/refresh")
    public ResponseEntity<?> refresh(@RequestParam String refreshToken) {

        return ResponseEntity.ok().build();
    }
}
