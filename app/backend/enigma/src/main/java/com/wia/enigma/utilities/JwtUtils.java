package com.wia.enigma.utilities;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.security.Keys;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Value;

import javax.crypto.SecretKey;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

@FieldDefaults(level = AccessLevel.PRIVATE)
public class JwtUtils {

    static JwtUtils instance;

    static String TOKEN_TYPE = "Bearer";

    @Value("${jwt.secret}")
    String JWT_SECRET;

    private JwtUtils(String jwtSecret) {
        this.JWT_SECRET = jwtSecret;
    }

    public static JwtUtils initInstance(String jwtSecret) {
        if (instance == null) instance = new JwtUtils(jwtSecret);
        return instance;
    }

    public static JwtUtils getInstance() {
        return instance;
    }

    /**
     * Extract the claims from the JWT.
     *
     * @param jwt JWT String
     * @return Claims
     */
    public Claims extractClaims(String jwt) {

        if (jwt == null || jwt.isEmpty())
            return null;

        Jws<Claims> jws;
        try {
            jws = Jwts.parser()
                    .verifyWith(getSignInKey())
                    .build()
                    .parseSignedClaims(jwt);
        } catch (Exception e) {
            return null;
        }

        return jws.getPayload();
    }

    /**
     * Check if the JWT is valid.
     *
     * @param jwt JWT String
     * @return jti
     */
    public String assertValidJwt(String jwt) {

        if (jwt == null || jwt.isEmpty())
            return null;

        Jws<Claims> jws;
        try {
            jws = Jwts.parser()
                    .verifyWith(getSignInKey())
                    .build()
                    .parseSignedClaims(jwt);
        } catch (Exception e) {
            return null;
        }

        try {
            Claims claims = jws.getPayload();
            if (claims.getExpiration().before(new Date()))
                return null;

            if (claims.getId() == null || claims.getId().isEmpty())
                return null;

            return claims.getId();
        } catch (Exception e) {
            return null;
        }
    }

    public String generateToken(Long enigmaUserId,
                                String username,
                                List<String> authorities,
                                Long jti,
                                String audienceValue,
                                Timestamp issuedAt,
                                Timestamp expiration) {

        return Jwts.builder()
                .header()
                .add("typ", "JWT").and()
                .subject(username)
                .audience().add(audienceValue).and()
                .claim("user_id", enigmaUserId)
                .claim("authorities", authorities)
                .id(jti.toString())
                .issuer("wia.com")
                .issuedAt(issuedAt)
                .expiration(expiration)
                .signWith(getSignInKey())
                .compact();
    }

    /**
     * Get the key used to sign the JWT.
     * Authentication is done using the HMAC-SHA256 algorithm.
     *
     * @return SecretKey
     */
    public SecretKey getSignInKey() {
        return Keys.hmacShaKeyFor(JWT_SECRET.getBytes());
    }

    /**
     * Get the token type.
     * @return String
     */
    public String getTokenType() {
        return TOKEN_TYPE;
    }
}
