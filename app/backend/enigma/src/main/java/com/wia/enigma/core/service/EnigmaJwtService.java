package com.wia.enigma.core.service;

import io.jsonwebtoken.Claims;
import org.springframework.security.core.userdetails.UserDetails;

public interface EnigmaJwtService {

    void validateJwt(String jwt);

    Claims extractClaims(String jwt);

    String generateToken(UserDetails userDetails);
}
