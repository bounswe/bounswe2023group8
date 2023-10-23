package com.wia.enigma.utilities;

import com.wia.enigma.configuration.security.EnigmaUserDetails;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.core.GrantedAuthority;

import java.security.Key;
import java.util.Date;
import java.util.UUID;
import java.util.stream.Collectors;

@FieldDefaults(level = AccessLevel.PRIVATE)
public class JwtUtils {

    static JwtUtils instance;

    @Value("${jwt.key}")
    String JWT_KEY;

    @Value("${jwt.expiration}")
    Long EXPIRATION;


    /**
     * Get the instance of the JwtUtils class.
     * Singleton pattern.
     *
     * @return JwtUtils
     */
    public static JwtUtils getInstance() {
        if (instance == null) instance = new JwtUtils();
        return instance;
    }

    /**
     * Extract all claims from the JWT.
     * Claims are the payload (body) of the JWT.
     *
     * @param jwt JWT String
     * @return Claims
     */
    Claims extractAllClaims(String jwt) {
        return null;
    }

    /**
     * Check if the JWT is valid.
     * A JWT is valid if it is not expired.
     * A JWT is valid if all required claims are present.
     *
     * @param jwt JWT String
     * @return Boolean
     */
    public Boolean isValidJwt(String jwt) {
        if (jwt == null || jwt.isEmpty()) return false;
        Claims claims = extractAllClaims(jwt);
        return !claims.getExpiration().before(new Date());
    }

    public String generateToken(EnigmaUserDetails enigmaUserDetails) {
        return Jwts.builder()
                .header()
                .add("typ", "JWT")
                .and()
                .subject(enigmaUserDetails.getUsername())
                .claim("user_id", enigmaUserDetails.getEnigmaUserId())
                .claim("aud", enigmaUserDetails.getAudienceType().getName())
                .claim("authorities", enigmaUserDetails
                        .getAuthorities()
                        .stream()
                        .map(GrantedAuthority::getAuthority)
                        .collect(Collectors.toList())
                )
                .issuer("wia.com")
                .issuedAt(new Date(System.currentTimeMillis()))
                .expiration(new Date(System.currentTimeMillis() + EXPIRATION))
                .signWith(getSignInKey())
                .id(getTokenIdentifier())
                .compact();
    }

    /**
     * TODO: Implement this method.
     * @return
     */
    private String getTokenIdentifier() {
        return UUID.randomUUID().toString();
    }

    /**
     * Get the key used to sign the JWT.
     * Authentication is done using the HMAC-SHA256 algorithm.
     *
     * @return SecretKey
     */
    public Key getSignInKey() {
        return Keys.hmacShaKeyFor(JWT_KEY.getBytes());
    }

    public Long getExpirationTime() {
        return EXPIRATION;
    }
}
