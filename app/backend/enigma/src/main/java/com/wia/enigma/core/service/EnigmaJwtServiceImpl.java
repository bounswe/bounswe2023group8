package com.wia.enigma.core.service;

import com.wia.enigma.dal.repository.EnigmaJwtRepository;
import io.jsonwebtoken.Claims;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaJwtServiceImpl implements EnigmaJwtService {

    final EnigmaJwtRepository jwtRepository;

    /**
     * Validates the JWT.
     * If the JWT is invalid, throws an exception.
     *
     * @param jwt JWT String
     */
    @Override
    public void validateJwt(String jwt) {

    }

    /**
     * Extract all claims from the JWT.
     * Claims are the payload (body) of the JWT.
     *
     * @param jwt JWT String
     * @return Claims
     */
    @Override
    public Claims extractClaims(String jwt) {

        return null;
    }


}
