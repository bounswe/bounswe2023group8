package com.wia.enigma.core.service;

import io.jsonwebtoken.Claims;

public interface EnigmaJwtService {

    void validateJwt(String jwt);

    Claims extractClaims(String jwt);
}
