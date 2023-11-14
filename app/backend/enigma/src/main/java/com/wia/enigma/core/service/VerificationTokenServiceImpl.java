package com.wia.enigma.core.service;


import com.wia.enigma.dal.entity.VerificationToken;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.VerificationTokenRepository;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.UUID;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VerificationTokenServiceImpl implements VerificationTokenService {

    @Value("${verification-token.expiration-time}")
    Long verificationTokenExpiration;

    final VerificationTokenRepository verificationTokenRepository;


    /**
     * Creates a new VerificationToken.
     *
     * @param enigmaUserId  enigmaUserId
     * @return              VerificationToken
     */
    @Override
    public VerificationToken createVerificationToken(Long enigmaUserId, Boolean isResetPasswordToken) {

        Timestamp now = new Timestamp(System.currentTimeMillis());
        Timestamp expiresAt = new Timestamp(now.getTime() + verificationTokenExpiration);
        String token = UUID.randomUUID().toString();

        return verificationTokenRepository.save(
                VerificationToken.builder()
                        .enigmaUserId(enigmaUserId)
                        .token(token)
                        .issuedAt(now)
                        .expiresAt(expiresAt)
                        .isRevoked(false)
                        .isResetPasswordToken(isResetPasswordToken)
                        .build()
        );
    }

    /**
     * Finds a VerificationToken by token.
     *
     * @param token token
     * @return      VerificationToken
     */
    @Override
    public VerificationToken verifyToken(String token, Boolean isResetPasswordToken) {

        String tokenType = isResetPasswordToken ? "Reset token" : "Verification token";
        VerificationToken verificationToken;
        try {
            verificationToken = verificationTokenRepository.findByTokenAndIsResetPasswordToken(token, isResetPasswordToken);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                        "Cannot get "+ tokenType +" by token.");
        }

        if (verificationToken == null)
            throw new EnigmaBadRequestException(ExceptionCodes.VERIFICATION_TOKEN_NOT_FOUND,
                    tokenType + " not found for token: " + token);

        if (verificationToken.getExpiresAt().before(new Timestamp(System.currentTimeMillis())))
            throw new EnigmaBadRequestException(ExceptionCodes.VERIFICATION_TOKEN_EXPIRED,
                    tokenType + " is expired for token: " + token);

        if(verificationToken.getIsRevoked())
            throw new EnigmaBadRequestException(ExceptionCodes.VERIFICATION_TOKEN_EXPIRED,
                    tokenType + " is already used for token: " + token);

        return verificationToken;
    }

    /**
     * Saves a VerificationToken.
     *
     * @param verificationToken verificationToken
     */
    @Override
    public void save(VerificationToken verificationToken) {

        try {
            verificationTokenRepository.save(verificationToken);
        } catch (Exception e) {

            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save VerificationToken.");
        }
    }

    /**
     * Revokes a VerificationToken.
     *
     * @param verificationToken verificationToken
     */
    @Override
    public void revoke(VerificationToken verificationToken) {

        verificationToken.setIsRevoked(true);
        try {
            verificationTokenRepository.save(verificationToken);
        } catch (Exception e) {

            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save VerificationToken.");
        }
    }
}
