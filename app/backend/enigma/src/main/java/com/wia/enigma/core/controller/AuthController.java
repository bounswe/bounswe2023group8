package com.wia.enigma.core.controller;


import com.wia.enigma.configuration.security.EnigmaUserDetailsService;
import com.wia.enigma.core.service.EnigmaJwtService;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.apache.coyote.Response;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequiredArgsConstructor
@RequestMapping("/auth")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthController {

    final EnigmaUserRepository userRepository;
    final EnigmaUserDetailsService userDetailsService;
    final EnigmaJwtService jwtService;

    @PostMapping("/login")
    public ResponseEntity<?> login(@RequestParam String username,
                                   @RequestParam String password) {
        UserDetails userDetails = userDetailsService.loadUserByUsername(username);
        if (userDetails != null && new BCryptPasswordEncoder().matches(password, userDetails.getPassword())) {
            String token = jwtService.generateToken(userDetails);
            return ResponseEntity.ok().header("Authorization", "Bearer " + token).build();
        }

        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    }


    @GetMapping("/refresh")
    public ResponseEntity<?> refresh(@RequestParam String refreshToken) {

        return ResponseEntity.ok().build();
    }

    @PostMapping("/register")
    public ResponseEntity<?> register(@RequestParam String username,
                                      @RequestParam String email,
                                      @RequestParam String password) {
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

        EnigmaUser newUser = new EnigmaUser();
        newUser.setUsername(username);
        newUser.setEmail(email);
        newUser.setPassword(encoder.encode(password));

        userRepository.save(newUser);

        return ResponseEntity.ok().build();
    }
}
