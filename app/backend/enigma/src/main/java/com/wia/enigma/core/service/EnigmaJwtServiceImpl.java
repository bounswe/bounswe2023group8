package com.wia.enigma.core.service;

import com.wia.enigma.dal.repository.EnigmaJwtRepository;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaJwtServiceImpl implements EnigmaJwtService {


    @Value("${jwt.secret}")
    private String SECRET_KEY;

    @Value("${jwt.expiration}")
    private long jwtExpiration;

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


    @Override
    public String generateToken(UserDetails userDetails) {
        Map<String, Object> claims = new HashMap<>();
        claims.put("sub", userDetails.getUsername());
        claims.put("roles", userDetails.getAuthorities());

        return Jwts.builder()
                .setClaims(claims)
                .setSubject(userDetails.getUsername())
                .setIssuedAt(new Date(System.currentTimeMillis()))
                .setExpiration(new Date(System.currentTimeMillis() + jwtExpiration))
                .signWith(SignatureAlgorithm.HS256, SECRET_KEY)
                .compact();
    }



}
