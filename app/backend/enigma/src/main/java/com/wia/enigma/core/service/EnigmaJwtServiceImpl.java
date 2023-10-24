package com.wia.enigma.core.service;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.JwtGenerationDto;
import com.wia.enigma.dal.entity.EnigmaJwt;
import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.EnigmaJwtRepository;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import com.wia.enigma.exceptions.custom.EnigmaUnauthorizedException;
import com.wia.enigma.utilities.AuthUtils;
import com.wia.enigma.utilities.JwtUtils;
import io.jsonwebtoken.Claims;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.util.Pair;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;
import java.util.UUID;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaJwtServiceImpl implements EnigmaJwtService {

    final EnigmaJwtRepository enigmaJwtRepository;

    @Value("${jwt.expiration.access-token}")
    Long accessTokenExpiration;

    @Value("${jwt.expiration.refresh-token}")
    Long refreshTokenExpiration;

    /**
     * Validates the JWT.
     *
     * @param jwt JWT String
     * @return EnigmaAuthenticationToken with the claims of the JWT
     */
    @Override
    public EnigmaAuthenticationToken validateJwt(String jwt) {

        Claims claims = JwtUtils.getInstance().extractClaims(jwt);
        if (claims == null)
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_JWT,
                    "Could not extract claims from JWT.");

        long jti;
        try {
            jti = Long.parseLong(claims.getId());
        } catch (Exception e) {
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_JWT_ID,
                    "Invalid JWT id.");
        }

        EnigmaJwt enigmaJwt;
        try {
            enigmaJwt = enigmaJwtRepository.findEnigmaJwtById(jti);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Could not get EnigmaJwt.");
        }

        if (enigmaJwt == null)
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_JWT_ID,
                    "EnigmaJwt not found for id: " + claims.getId());

        if (enigmaJwt.getRevokedAt() != null)
            throw new EnigmaUnauthorizedException(ExceptionCodes.REVOKED_JWT,
                    "EnigmaJwt is revoked.");

        if (enigmaJwt.getExpiresAt().before(new Timestamp(System.currentTimeMillis())))
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_JWT_EXPIRATION,
                    "EnigmaJwt is expired.");

        return new EnigmaAuthenticationToken(
                claims.getSubject(),
                null,
                ((Integer) claims.get("user_id")).longValue(),
                AudienceType.fromAudienceSet(claims.getAudience()),
                Long.parseLong(claims.getId()),
                AuthUtils.getInstance().buildAuthorities(claims.get("authorities"))
        );
    }

    /**
     * Revokes the token.
     *
     * @param enigmaJwtId  EnigmaJwt.Id
     */
    @Override
    public void revokeToken(Long enigmaJwtId) {

        EnigmaJwt enigmaJwt;
        try {
            enigmaJwt = enigmaJwtRepository.findEnigmaJwtById(enigmaJwtId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Could not get EnigmaJwt.");
        }

        if (enigmaJwt == null)
            throw new EnigmaBadRequestException(ExceptionCodes.INVALID_JWT_ID,
                    "EnigmaJwt not found for id: " + enigmaJwtId);

        enigmaJwt.setRevokedAt(new Timestamp(System.currentTimeMillis()));
        try {
            enigmaJwtRepository.save(enigmaJwt);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Could not save EnigmaJwt.");
        }
    }

    /**
     * Generates a new access token or refresh token.
     *
     * @param enigmaUserId      EnigmaUser.Id
     * @param username          EnigmaUser.username
     * @param authorities       Authorities List of EnigmaUser
     * @param audienceValue     EnigmaUser.audienceValue
     * @param isRefreshToken    specifies if the token is a refresh token
     * @return                  JwtGenerationDto
     */
    @Override
    public JwtGenerationDto generateToken(Long enigmaUserId,
                                          String username,
                                          List<String> authorities,
                                          String audienceValue,
                                          Boolean isRefreshToken) {

        return generateToken(enigmaUserId, username, authorities, audienceValue, new Timestamp(System.currentTimeMillis()), isRefreshToken);
    }

    /**
     * Generates a new access token and refresh token.
     *
     * @param enigmaUserId      EnigmaUser.Id
     * @param username          EnigmaUser.username
     * @param authorities       Authorities List of EnigmaUser
     * @param audienceValue     EnigmaUser.audienceValue
     * @return                  Pair: first -> access token, second -> refresh token
     */
    @Override
    public Pair<JwtGenerationDto, JwtGenerationDto> generateTokens(Long enigmaUserId,
                                                                   String username,
                                                                   List<String> authorities,
                                                                   String audienceValue) {

        Timestamp now = new Timestamp(System.currentTimeMillis());

        JwtGenerationDto accessToken = generateToken(enigmaUserId, username, authorities, audienceValue, now, false);
        JwtGenerationDto refreshToken = generateToken(enigmaUserId, username, authorities, audienceValue, now, true);

        return Pair.of(accessToken, refreshToken);
    }

    private JwtGenerationDto generateToken(Long enigmaUserId,
                                           String username,
                                           List<String> authorities,
                                           String audienceValue,
                                           Timestamp issuedAt,
                                           Boolean isRefreshToken) {

        Long jti = UUID.randomUUID().getLeastSignificantBits();
        Timestamp expiresAt = new Timestamp(issuedAt.getTime() +
                (isRefreshToken ? refreshTokenExpiration : accessTokenExpiration));

        EnigmaJwt enigmaJwt = EnigmaJwt.builder()
                .id(jti)
                .enigmaUserId(enigmaUserId)
                .issuedAt(issuedAt)
                .expiresAt(expiresAt)
                .isRefreshToken(isRefreshToken)
                .build();

        try {
            enigmaJwtRepository.save(enigmaJwt);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save Enigma Jwt.");
        }

        String jwt = JwtUtils.getInstance()
                .generateToken(enigmaUserId, username, authorities, jti, audienceValue, issuedAt, expiresAt);

        return new JwtGenerationDto(jwt, issuedAt, (isRefreshToken ? refreshTokenExpiration : accessTokenExpiration));
    }
}
