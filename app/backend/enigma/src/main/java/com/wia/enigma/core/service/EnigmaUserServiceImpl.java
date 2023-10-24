package com.wia.enigma.core.service;

import com.wia.enigma.core.data.dto.JwtGenerationDto;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.SecurityDetailsResponse;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import com.wia.enigma.exceptions.custom.EnigmaRuntimeException;
import com.wia.enigma.exceptions.custom.EnigmaUnauthorizedException;
import com.wia.enigma.utilities.JwtUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.http.HttpHeaders;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserServiceImpl implements EnigmaUserService {

    final PasswordEncoder passwordEncoder;

    final EnigmaUserRepository enigmaUserRepository;

    final EnigmaJwtService enigmaJwtService;

    /**
     * Registers a new EnigmaUser.
     *
     * @param username      username
     * @param email         email
     * @param password      password
     * @param birthday      birthday
     * @return              RegisterResponse
     */
    @Override
    @Transactional
    public RegisterResponse registerEnigmaUser(String username,
                                               String email,
                                               String password,
                                               String birthday) {

        /* TODO: send verification email to user */

        /* check the uniqueness of username and email */
        assertEnigmaUserDoesNotExist(username, email);

        Date birthdayDate;
        try {
            birthdayDate = Date.valueOf(birthday);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaBadRequestException(ExceptionCodes.INVALID_DATE_FORMAT,
                    "Birthday is not in the correct format. Use \"yyyy-[m]m-[d]d\"");
        }

        if (username.contains("@"))
            throw new EnigmaBadRequestException(ExceptionCodes.INVALID_USERNAME,
                    "Username cannot contain '@'.");

        EnigmaUser enigmaUser = EnigmaUser.builder()
                .username(username)
                .email(email)
                .password(passwordEncoder.encode(password))
                .birthday(birthdayDate)
                .audienceType(AudienceType.USER.getName())
                .isDeleted(false)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        try {
            enigmaUser = enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save EnigmaUser.");
        }

        /* TODO: set up authorities structure */
        List<String> authorities = new ArrayList<>();

        Pair<JwtGenerationDto, JwtGenerationDto> tokens = enigmaJwtService.generateTokens(
                enigmaUser.getId(),
                enigmaUser.getUsername(),
                authorities,
                enigmaUser.getAudienceType()
        );

        return RegisterResponse.builder()
                .enigmaUserId(enigmaUser.getId())
                .authentication(SecurityDetailsResponse.builder()
                        .accessToken(tokens.getFirst().getJwt())
                        .refreshToken(tokens.getSecond().getJwt())
                        .expiresIn(tokens.getFirst().getExpiresIn())
                        .tokenType(JwtUtils.getInstance().getTokenType())
                        .build())
                .build();
    }

    /**
     * Logs in an EnigmaUser.
     *
     * @param usernameOrEmail   username or email
     * @param password          password
     * @return                  LoginResponse
     */
    @Override
    public LoginResponse loginEnigmaUser(String usernameOrEmail, String password) {

        EnigmaUser enigmaUser;
        try {
            if (usernameOrEmail.contains("@"))
                enigmaUser = enigmaUserRepository.findEnigmaUserByEmail(usernameOrEmail);
            else
                enigmaUser = enigmaUserRepository.findEnigmaUserByUsername(usernameOrEmail);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by username or email.");
        }

        if (enigmaUser == null)
            throw new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for username or email: " + usernameOrEmail);

        if (!passwordEncoder.matches(password, enigmaUser.getPassword()))
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_PASSWORD,
                    "Password is not valid.");

        /* TODO: set up authorities structure */
        List<String> authorities = new ArrayList<>();

        Pair<JwtGenerationDto, JwtGenerationDto> tokens = enigmaJwtService.generateTokens(
                enigmaUser.getId(),
                enigmaUser.getUsername(),
                authorities,
                enigmaUser.getAudienceType()
        );

        return LoginResponse.builder()
                .authentication(SecurityDetailsResponse.builder()
                        .tokenType(JwtUtils.getInstance().getTokenType())
                        .accessToken(tokens.getFirst().getJwt())
                        .refreshToken(tokens.getSecond().getJwt())
                        .expiresIn(tokens.getFirst().getExpiresIn())
                        .build())
                .build();
    }

    /**
     * Logs out the EnigmaUser identified by the JWT.
     *
     * @param authorizationHeader "Authorization" header
     */
    @Override
    public void logoutEnigmaUser(String authorizationHeader) {

        if (authorizationHeader == null)
            throw new EnigmaUnauthorizedException(ExceptionCodes.MISSING_AUTHORIZATION_HEADER,
                    "Missing Authorization header");

        if (!authorizationHeader.startsWith(JwtUtils.getInstance().getTokenType()))
            throw new EnigmaUnauthorizedException(ExceptionCodes.INVALID_AUTHORIZATION_HEADER,
                    "Invalid Authorization header");

        String jti = JwtUtils.getInstance()
                .assertValidJwt(authorizationHeader.substring(JwtUtils.getInstance().getTokenType().length() + 1).trim());

        long enigmaJwtId;
        try {
            enigmaJwtId = Long.parseLong(jti);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaBadRequestException(ExceptionCodes.INVALID_JWT,
                    "JTI is not valid.");
        }

        try {
            enigmaJwtService.revokeToken(enigmaJwtId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_DELETE_ERROR,
                    "Cannot delete JWT.");
        }
    }


    /**
     * Asserts that the enigma user with either username or email does not exist.
     *
     * @param username  username to check
     * @param email     email to check
     */
    private void assertEnigmaUserDoesNotExist(String username, String email) {

        boolean exists;
        try {
            exists = enigmaUserRepository.existsByUsernameOrEmail(username, email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot check EnigmaUser existence.");
        }

        if (exists)
            throw new EnigmaDatabaseException(ExceptionCodes.DB_UNIQUE_CONSTRAINT_VIOLATION,
                    "EnigmaUser with username or email already exists.");
    }
}
