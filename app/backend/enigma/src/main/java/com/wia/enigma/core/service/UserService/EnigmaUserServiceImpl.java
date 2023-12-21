package com.wia.enigma.core.service.UserService;

import com.wia.enigma.core.data.dto.*;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.SecurityDetailsResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.core.service.EmailService.EmailService;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.JwtService.EnigmaJwtService;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.core.service.StorageService.StorageService;
import com.wia.enigma.core.service.UserFollowsService.UserFollowsService;
import com.wia.enigma.core.service.VerificationTokenService.VerificationTokenService;
import com.wia.enigma.dal.entity.*;
import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.*;
import com.wia.enigma.exceptions.custom.*;
import com.wia.enigma.utilities.JwtUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.util.Pair;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.*;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserServiceImpl implements EnigmaUserService {

    final PasswordEncoder passwordEncoder;

    final EnigmaUserRepository enigmaUserRepository;
    final EntityTagsRepository entityTagsRepository;
    final WikiTagRepository wikiTagRepository;
    final PostCommentRepository postCommentRepository;
    final PostVoteRepository postVoteRepository;
    final PostRepository postRepository;
    final InterestAreaRepository interestAreaRepository;

    final EmailService emailService;
    final EnigmaJwtService enigmaJwtService;
    final InterestAreaService interestAreaService;
    final PostService postService;
    final UserFollowsService userFollowsService;
    final VerificationTokenService verificationTokenService;
    final StorageService storageService;

    @Override
    public EnigmaUserDto getUser(Long id){

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + id);

        return enigmaUser.mapToEnigmaUserDto();
    }

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
                                               String name,
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
            throw new EnigmaException(ExceptionCodes.INVALID_DATE_FORMAT,
                    "Birthday is not in the correct format. Use \"yyyy-[m]m-[d]d\"");
        }

        if (username.contains("@"))
            throw new EnigmaException(ExceptionCodes.INVALID_USERNAME,
                    "Username cannot contain '@'.");

        EnigmaUser enigmaUser = EnigmaUser.builder()
                .username(username)
                .name(name)
                .email(email)
                .password(passwordEncoder.encode(password))
                .birthday(birthdayDate)
                .audienceType(AudienceType.USER.getName())
                .isVerified(false)
                .createTime(new Timestamp(System.currentTimeMillis()))
                .build();

        try {
            enigmaUser = enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save EnigmaUser.");
        }

        VerificationToken verificationToken = verificationTokenService.createVerificationToken(enigmaUser.getId(), false);
        try {
            emailService.sendVerificationEmail(enigmaUser.getEmail(), verificationToken.getToken());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
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
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by username or email.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for username or email: " + usernameOrEmail);

        if (!passwordEncoder.matches(password, enigmaUser.getPassword()))
            throw new EnigmaException(ExceptionCodes.INVALID_PASSWORD,
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
                .userId(enigmaUser.getId())
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
            throw new EnigmaException(ExceptionCodes.MISSING_AUTHORIZATION_HEADER,
                    "Missing Authorization header");

        if (!authorizationHeader.startsWith(JwtUtils.getInstance().getTokenType()))
            throw new EnigmaException(ExceptionCodes.INVALID_AUTHORIZATION_HEADER,
                    "Invalid Authorization header");

        String jti = JwtUtils.getInstance()
                .assertValidJwt(authorizationHeader.substring(JwtUtils.getInstance().getTokenType().length() + 1).trim());

        long enigmaJwtId;
        try {
            enigmaJwtId = Long.parseLong(jti);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.INVALID_JWT,
                    "JTI is not valid.");
        }

        try {
            enigmaJwtService.revokeToken(enigmaJwtId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_DELETE_ERROR,
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
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot check EnigmaUser existence.");
        }

        if (exists)
            throw new EnigmaException(ExceptionCodes.DB_UNIQUE_CONSTRAINT_VIOLATION,
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
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + verificationToken.getEnigmaUserId() + " or it is already verified.");

        boolean alreadyExist;
        try {
            alreadyExist = enigmaUserRepository.existsByUsernameOrEmail(enigmaUser.getUsername(), enigmaUser.getEmail());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by username or email.");
        }

        if (alreadyExist)
            throw new EnigmaException(ExceptionCodes.USERNAME_OR_EMAIL_ALREADY_VERIFIED,
                    "A user with the same username  or email exists.");

        enigmaUser.setIsVerified(true);
        try {
            enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
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
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by email.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
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
            throw new EnigmaException(ExceptionCodes.PASSWORDS_DO_NOT_MATCH,
                    "Passwords do not match.");

        VerificationToken verificationToken = verificationTokenService.verifyToken(token, true);
        verificationTokenService.revoke(verificationToken);

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(verificationToken.getEnigmaUserId());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + verificationToken.getEnigmaUserId());

        enigmaUser.setPassword(passwordEncoder.encode(newPassword1));
        try {
            enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
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
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "User does not exist or unverified!");
        }

        if (userId.equals(followId)) {
            throw new EnigmaException(ExceptionCodes.NON_AUTHORIZED_ACTION,
                    "You cannot follow yourself.");
        }

        userFollowsService.follow(userId, followId, EntityType.USER, true);
    }

    @Override
    @Transactional
    public void unfollowUser(Long userId, Long followId) {

        EnigmaUserDto enigmaUser = getVerifiedUser(followId);

        if(enigmaUser == null) {
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "User does not exist or unverified!");
        }

        userFollowsService.unfollow(userId, followId, EntityType.USER);
    }

    @Override
    public List<EnigmaUserDto> getFollowers(Long userId, Long followedId) {

        EnigmaUserDto followedEnigmaUser = getVerifiedUser(followedId);

        if (followedEnigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "User does not exist or unverified!");

        return userFollowsService.findFollowers( followedId, EntityType.USER, true)
                .stream()
                .map(userFollows -> enigmaUserRepository.findEnigmaUserById(userFollows.getFollowerEnigmaUserId()))
                .map(EnigmaUser::mapToEnigmaUserDto)
                .toList();
    }

    @Override
    public Long getFollowerCount(Long userId) {
        return userFollowsService.countAcceptedFollowers(userId, EntityType.USER);
    }

    @Override
    public List<EnigmaUserDto>  getFollowings(Long userId, Long followerId) {

        EnigmaUserDto followedEnigmaUser = getVerifiedUser(followerId);

        if(followedEnigmaUser == null) {
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "User does not exist or unverified!");
        }

        return userFollowsService.findFollowings(followerId, EntityType.USER, true)
                .stream()
                .map(userFollows -> enigmaUserRepository.findEnigmaUserById(userFollows.getFollowedEntityId()))
                .map(EnigmaUser::mapToEnigmaUserDto)
                .toList();
    }

    @Override
    public Long getFollowingCount(Long userId) {
        return userFollowsService.countAcceptedFollowers(userId, EntityType.USER);
    }

    @Override
    public List<PostDto> getPosts(Long requesterId, Long userId){

        EnigmaUserDto enigmaUser = getVerifiedUser(userId);

        if(enigmaUser == null) {
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "User does not exist or unverified!");
        }

        List<Post> posts = postRepository.findByEnigmaUserId(userId);

        List<Long> interestAreaIds = posts.stream().map(Post::getInterestAreaId).toList();

        List<InterestArea> interestAreas = interestAreaRepository.findAllById(interestAreaIds);

        return posts.stream().filter(
                post ->
                {
                    try{
                        userFollowsService.checkInterestAreaAccess( interestAreas.stream().filter(interestArea -> interestArea.getId().equals(post.getInterestAreaId())).toList().get(0), requesterId);
                        return true;

                    }catch (Exception e){
                        return false;
                    }
                }
        ).map(post -> post.mapToPostDto(
                getWikiTags(post.getId(), EntityType.POST),
                enigmaUser,
                interestAreas.stream().filter(interestArea -> interestArea.getId().equals(post.getInterestAreaId()))
                        .toList().get(0).mapToInterestAreaModel(),
                postVoteRepository.countByPostIdAndVote(post.getId(), true),
                postVoteRepository.countByPostIdAndVote(post.getId(), false),
                postCommentRepository.countByPostId(post.getId())
        )).toList();
    }

    @Override
    public List<InterestAreaDto> getFollowingInterestAreas(Long userId, Long followerId ) {
        List<Long> followedEntityIds = userFollowsService.findFollowings(followerId, EntityType.INTEREST_AREA, true)
                .stream()
                .map(UserFollows::getFollowedEntityId)
                .collect(Collectors.toList());

        if (followedEntityIds.isEmpty()) {
            return Collections.emptyList();
        }

        List<InterestArea> interestAreas = interestAreaRepository.findAllById(followedEntityIds);

        return interestAreas.stream()
                .filter(interestArea -> Objects.equals(userId, followerId) || interestArea.getAccessLevel().equals(EnigmaAccessLevel.PUBLIC))
                .map(interestArea -> interestArea.mapToInterestAreaDto(getWikiTags(interestArea.getId(), EntityType.INTEREST_AREA) )).toList();
    }

    @Override
    public List<InterestAreaDto> getInterestAreaFollowRequests(Long userId){

        List<Long> followedEntityIds = userFollowsService.findFollowings(userId, EntityType.INTEREST_AREA, false)
                .stream()
                .map(UserFollows::getFollowedEntityId)
                .toList();

        if (followedEntityIds.isEmpty()) {
            return Collections.emptyList();
        }

        List<InterestArea> interestAreas = interestAreaRepository.findAllById(followedEntityIds);

        return interestAreas.stream().map(interestArea -> interestArea.mapToInterestAreaDto(getWikiTags(interestArea.getId(), EntityType.INTEREST_AREA))).toList();
    }

    @Override
    public EnigmaUserDto getVerifiedUser(Long userId ){

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + userId);

        return enigmaUser.mapToEnigmaUserDto();
    }

    @Override
    public List<EnigmaUserDto> search(Long userId, String searchKey) {

        return enigmaUserRepository.findByIsVerifiedTrueAndUsernameContainsOrNameContains(searchKey, searchKey)
                .stream()
                .map(EnigmaUser::mapToEnigmaUserDto)
                .toList();
    }

    /**
     * Deletes the EnigmaUser.
     *
     * @param userId  enigma user id
     */
    @Override
    @Transactional
    public void deleteUser(Long userId) {

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + userId);

        try {
            enigmaUserRepository.delete(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_DELETE_ERROR,
                    "Cannot delete EnigmaUser.");
        }

        enigmaJwtService.revokeAllTokens(userId);
        interestAreaService.deleteInterestAreasForUser(userId);
        userFollowsService.deleteAllForUser(userId);
        postService.deleteAllForUser(userId);
    }

    /**
     * Validates the existence of the EnigmaUser.
     *
     * @param userId   enigma user id
     */
    @Override
    public void validateExistence(Long userId) {

            EnigmaUser enigmaUser;
            try {
                enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                        "Cannot get EnigmaUser by id.");
            }

            if (enigmaUser == null)
                throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                        "EnigmaUser not found for id: " + userId);
    }

    /**
     * Change the password of an existing user
     *
     * @param enigmaUserId  EnigmaUser.id
     * @param oldPassword   Old password
     * @param newPassword1  new password
     * @param newPassword2  new password
     */
    @Override
    public void changePassword(Long enigmaUserId, String oldPassword, String newPassword1, String newPassword2) {

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(enigmaUserId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + enigmaUserId);

        if (!passwordEncoder.matches(oldPassword, enigmaUser.getPassword()))
            throw new EnigmaException(ExceptionCodes.INVALID_PASSWORD,
                    "Current password is not valid.");

        if (!newPassword1.equals(newPassword2))
            throw new EnigmaException(ExceptionCodes.PASSWORDS_DO_NOT_MATCH,
                    "Passwords do not match.");

        enigmaUser.setPassword(passwordEncoder.encode(newPassword1));
        try {
            enigmaUserRepository.save(enigmaUser);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Cannot save EnigmaUser.");
        }
    }

    private List<WikiTag> getWikiTags(Long id, EntityType entityType) {
        return wikiTagRepository.findAllById(entityTagsRepository.findAllByEntityIdAndEntityType(id, entityType).stream()
                .map(EntityTag::getWikiDataTagId)
                .collect(Collectors.toList()));
    }

    @Override
    public void uploadProfilePicture(Long userId, MultipartFile file) {

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + userId);


        String uploadedFileUrl  = storageService.uploadFile(file, "enigma-profile", UUID.randomUUID().toString());

        enigmaUser.setPictureUrl(uploadedFileUrl);

        enigmaUserRepository.save(enigmaUser);
    }

    @Override
    public void deleteProfilePicture(Long userId) {

        EnigmaUser enigmaUser;
        try {
            enigmaUser = enigmaUserRepository.findEnigmaUserById(userId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Cannot get EnigmaUser by id.");
        }

        if (enigmaUser == null)
            throw new EnigmaException(ExceptionCodes.USER_NOT_FOUND,
                    "EnigmaUser not found for id: " + userId);

        enigmaUser.setPictureUrl(null);

        enigmaUserRepository.save(enigmaUser);
    }
}