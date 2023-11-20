package com.wia.enigma.core.service.UserService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.dto.JwtGenerationDto;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.SecurityDetailsResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.core.service.EmailService.EmailService;
import com.wia.enigma.core.service.JwtService.EnigmaJwtService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.VerificationTokenService.VerificationTokenService;
import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.entity.UserFollows;
import com.wia.enigma.dal.entity.VerificationToken;
import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import com.wia.enigma.dal.repository.InterestAreaRepository;
import com.wia.enigma.dal.repository.UserFollowsRepository;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaConflictException;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import com.wia.enigma.exceptions.custom.EnigmaUnauthorizedException;
import com.wia.enigma.utilities.JwtUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserServiceImpl implements EnigmaUserService {
    private final InterestAreaRepository interestAreaRepository;

    final PasswordEncoder passwordEncoder;

    final EnigmaUserRepository enigmaUserRepository;

    final EnigmaJwtService enigmaJwtService;

    final VerificationTokenService verificationTokenService;

    final EmailService emailService;

    final UserFollowsService userFollowsService;


    /**
     * Registers a new EnigmaUser.
     *
     * @param username      username
     * @param email         email
     * @param password      password
     * @param birthday      birthday
     */
    @Override
    @Transactional
    public RegisterResponse registerEnigmaUser(String username,
                                               String email,
                                               String password,
                                               String birthday) {

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
                .isVerified(false)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        try {
            enigmaUser = enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save EnigmaUser.");
        }

        VerificationToken verificationToken = verificationTokenService.createVerificationToken(enigmaUser.getId(), false);
        try {
            emailService.sendVerificationEmail(enigmaUser.getEmail(), verificationToken.getToken());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot send verification email.");
        }

        return RegisterResponse.builder()
                .enigmaUserId(enigmaUser.getId())
                .verified(enigmaUser.getIsVerified())
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
                enigmaUser = enigmaUserRepository.findEnigmaUserByUsername(usernameOrEmail, true);
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
            throw new EnigmaConflictException(ExceptionCodes.DB_UNIQUE_CONSTRAINT_VIOLATION,
                    "EnigmaUser with username or email already exists.");
    }

    /**
     * Verifies the EnigmaUser.
     *
     * @param token token
     * @return      VerificationResponse
     */
    @Override
    public VerificationResponse verifyEnigmaUser(String token) {

        VerificationToken verificationToken = verificationTokenService.verifyToken(token, false);
        verificationTokenService.revoke(verificationToken);

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserByNotVerified(verificationToken.getEnigmaUserId());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + verificationToken.getEnigmaUserId() + " or it is already verified.");

        boolean alreadyExist;
        try {
            alreadyExist = enigmaUserRepository.existsByUsernameOrEmail(enigmaUser.getUsername(), enigmaUser.getEmail());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by username or email.");
        }

        if (alreadyExist)
            throw new EnigmaBadRequestException(ExceptionCodes.USERNAME_OR_EMAIL_ALREADY_VERIFIED,
                    "A user with the same username  or email exists.");

        enigmaUser.setIsVerified(true);
        try {
            enigmaUserRepository.save(enigmaUser);
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

        return VerificationResponse.builder()
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
     * Sends a password reset email to the EnigmaUser.
     *
     * @param email email
     */
    @Override
    public void forgotPassword(String email) {

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserByEmail(email);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by email.");
        }

        if (enigmaUser == null)
            throw new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for email: " + email);

        VerificationToken verificationToken = verificationTokenService.createVerificationToken(enigmaUser.getId(), true);
        emailService.sendPasswordResetEmail(enigmaUser.getEmail(), verificationToken.getToken());
    }

    /**
     * Resets the password of the EnigmaUser.
     *
     * @param token token
     * @param newPassword1 first new password
     * @param newPassword2 second new password
     */
    @Override
    public void resetPassword(String token, String newPassword1, String newPassword2) {

        if (!newPassword1.equals(newPassword2))
            throw new EnigmaBadRequestException(ExceptionCodes.PASSWORDS_DO_NOT_MATCH,
                    "Passwords do not match.");

        VerificationToken verificationToken = verificationTokenService.verifyToken(token, true);
        verificationTokenService.revoke(verificationToken);

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(verificationToken.getEnigmaUserId());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + verificationToken.getEnigmaUserId());

        enigmaUser.setPassword(passwordEncoder.encode(newPassword1));
        try {
            enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save EnigmaUser.");
        }

        verificationToken.setIsRevoked(true);
        verificationTokenService.save(verificationToken);
    }

    @Override
    @Transactional
    public void followUser(Long userId, Long followId) {

        EnigmaUserDto enigmaUser = getVerifiedUser(followId);

        if(enigmaUser == null) {
            throw new IllegalArgumentException("User does not exist or unverified!");
        }

        if (userId.equals(followId)) {
            throw new IllegalArgumentException("You cannot follow yourself");
        }

        Optional<UserFollows> userFollows = userFollowsService.findUserFollowsEntity(userId, followId, EntityType.USER);

        if(userFollows.isPresent()) {

            if(userFollows.get().getIsAccepted()){
                throw new IllegalArgumentException("You are already following this " + EntityType.USER);
            }
            else {
                throw new IllegalArgumentException("You already sent a follow request to this " + EntityType.USER);
            }
        }

        UserFollows userFollow = UserFollows.builder()
                .followerEnigmaUserId(userId)
                .followedEntityId(followId)
                .followedEntityType(EntityType.USER)
                .isAccepted(true)
                .build();

        userFollowsService.follow(userFollow);
    }

    @Override
    @Transactional
    public void unfollowUser(Long userId, Long followId) {

        EnigmaUserDto enigmaUser = getVerifiedUser(followId);

        if(enigmaUser == null) {
            throw new IllegalArgumentException("User does not exist or unverified!");
        }

        userFollowsService.unfollow(userId, followId, EntityType.USER);
    }

    @Override
    public List<EnigmaUserDto> getFollowers(Long userId, Long followedId) {

        EnigmaUserDto followedEnigmaUser = getVerifiedUser(followedId);

        if(followedEnigmaUser == null) {
            throw new IllegalArgumentException("User does not exist or unverified!");
        }

        return userFollowsService.findAcceptedFollowers( followedId, EntityType.USER)
                .stream()
                .map(userFollows -> enigmaUserRepository.findEnigmaUserById(userFollows.getFollowerEnigmaUserId()))
                .map(enigmaUser -> EnigmaUserDto.builder()
                        .id(enigmaUser.getId())
                        .username(enigmaUser.getUsername())
                        .name(enigmaUser.getName())
                        .email(enigmaUser.getEmail())
                        .birthday(enigmaUser.getBirthday())
                        .createTime(enigmaUser.getCreateTime())
                        .build())
                .toList();
    }

    @Override
    public List<EnigmaUserDto>  getFollowings(Long userId, Long followerId) {

        EnigmaUserDto followedEnigmaUser = getVerifiedUser(followerId);

        if(followedEnigmaUser == null) {
            throw new IllegalArgumentException("User does not exist or unverified!");
        }

        return userFollowsService.findAcceptedFollowings(followerId, EntityType.USER)
                .stream()
                .map(userFollows -> enigmaUserRepository.findEnigmaUserById(userFollows.getFollowedEntityId()))
                .map(enigmaUser -> EnigmaUserDto.builder()
                        .id(enigmaUser.getId())
                        .username(enigmaUser.getUsername())
                        .name(enigmaUser.getName())
                        .email(enigmaUser.getEmail())
                        .birthday(enigmaUser.getBirthday())
                        .createTime(enigmaUser.getCreateTime())
                        .build())
                .toList();
    }

    @Override
    public List<InterestAreaSimpleDto> getFollowingInterestAreas(Long userId, Long followerId){

        return userFollowsService.findAcceptedFollowings(followerId, EntityType.INTEREST_AREA)
                .stream()
                .map(userFollows -> interestAreaRepository.findInterestAreaById(userFollows.getFollowedEntityId()))
                .map(interestArea -> InterestAreaSimpleDto.builder()
                        .id(interestArea.getId())
                        .name(interestArea.getName())
                        .enigmaUserId(interestArea.getEnigmaUserId())
                        .accessLevel(interestArea.getAccessLevel())
                        .createTime(interestArea.getCreateTime())
                        .build()).
                filter(interestAreaSimpleDto  -> userId ==followerId || interestAreaSimpleDto.getAccessLevel().equals(EnigmaAccessLevel.PUBLIC))
                .toList();
    }

    @Override
    public EnigmaUserDto getVerifiedUser(Long userId ){

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + userId);

        return EnigmaUserDto.builder()
                .id(enigmaUser.getId())
                .username(enigmaUser.getUsername())
                .email(enigmaUser.getEmail())
                .birthday(enigmaUser.getBirthday())
                .build();
    }
}