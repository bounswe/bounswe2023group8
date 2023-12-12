package com.wia.enigma.core.service;


import com.wia.enigma.core.data.dto.EnigmaAuthorities;
import com.wia.enigma.core.data.dto.ModerationDto;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.dal.entity.Moderation;
import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.enums.ModerationType;
import com.wia.enigma.dal.repository.ModerationRepository;
import com.wia.enigma.dal.specification.ModerationSpecification;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ModerationServiceImpl implements ModerationService {

    final ModerationRepository moderationRepository;

    final InterestAreaService interestAreaService;
    final PostService postService;

    /**
     * Remove a post using the moderation service
     *
     * @param authorities   EnigmaAuthorities of the user
     * @param postId        id of the post to be removed
     */
    @Override
    public void removePost(EnigmaAuthorities authorities, Long postId) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (postId == null)
            throw new IllegalArgumentException("postId cannot be null");

        if (authorities.getAudienceType() == AudienceType.USER)
            if (authorities.canModerate(postService.getInterestAreaIdOfPost(postId)))
                throw new IllegalArgumentException("Only moderators can remove posts");

        postService.deletePost(postId);
    }

    /**
     * Remove an interest area using the moderation service
     *
     * @param authorities       EnigmaAuthorities of the user
     * @param interestAreaId    id of the interest area to be removed
     */
    @Override
    public void removeInterestArea(EnigmaAuthorities authorities, Long interestAreaId) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (interestAreaId == null)
            throw new IllegalArgumentException("interestAreaId cannot be null");

        if (authorities.getAudienceType() == AudienceType.USER)
            throw new IllegalArgumentException("Only admins can remove interest areas");

        interestAreaService.deleteInterestAreaById(interestAreaId);
    }

    /**
     * Warn a user using the moderation service
     *
     * @param authorities   EnigmaAuthorities of the user
     * @param userId        id of the user to be warned
     * @param postId        id of the post to be warned
     * @param reason        comment to be added to the warning
     * @return              id of the moderation
     */
    @Override
    public Long warnUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason) {

        Long interestAreaId = initialCheck(authorities, userId, postId, reason);

        Moderation moderation = Moderation.builder()
                .moderationType(ModerationType.WARNING.getType())
                .reason(reason)
                .fromEnigmaUserId(authorities.getEnigmaUserId())
                .toEnigmaUserId(userId)
                .interestAreaId(interestAreaId)
                .postId(postId)
                .build();

        try {
            moderationRepository.save(moderation);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Could not save moderation.");
        }

        return moderation.getId();
    }

    /**
     * Ban a user using the moderation service
     *
     * @param authorities   EnigmaAuthorities of the user
     * @param userId        id of the user to be banned
     * @param postId        id of the post to be banned
     * @param reason        comment to be added to the ban
     * @return              id of the moderation
     */
    @Override
    public Long banUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason) {

        Long interestAreaId = initialCheck(authorities, userId, postId, reason);

        Moderation moderation = Moderation.builder()
                .moderationType(ModerationType.BAN.getType())
                .reason(reason)
                .fromEnigmaUserId(authorities.getEnigmaUserId())
                .toEnigmaUserId(userId)
                .interestAreaId(interestAreaId)
                .postId(postId)
                .build();

        try {
            moderationRepository.save(moderation);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Could not save moderation.");
        }

        return moderation.getId();
    }

    /**
     * Unban a user using the moderation service
     *
     * @param authorities       EnigmaAuthorities of the user
     * @param userId            id of the user to be unbanned
     * @param interestAreaId    id of the interest area
     */
    @Override
    @Transactional
    public void unbanUser(EnigmaAuthorities authorities, Long userId, Long interestAreaId) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (userId == null)
            throw new IllegalArgumentException("postId cannot be null");

        if (interestAreaId == null)
            throw new IllegalArgumentException("postId cannot be null");

        if (authorities.getAudienceType() == AudienceType.USER)
            if (authorities.canModerate(interestAreaId))
                throw new IllegalArgumentException("Only moderators can unban users");

        interestAreaService.validateExistence(interestAreaId);

        try {
            moderationRepository.deleteAllByToEnigmaUserIdAndInterestAreaIdAndModerationType(userId, interestAreaId, ModerationType.BAN.getType());
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch moderation.");
        }
    }

    /**
     * Report an issue using the moderation service
     *
     * @param authorities       EnigmaAuthorities of the user
     * @param userId            id of the user to be reported
     * @param postId            id of the post to be reported
     * @param interestAreaId    id of the interest area
     * @param reason            comment to be added to the report
     * @return                  id of the moderation
     */
    @Override
    public Long reportIssue(EnigmaAuthorities authorities, Long userId, Long postId, Long interestAreaId, String reason) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (reason == null)
            throw new IllegalArgumentException("reason cannot be null");

        Moderation moderation = Moderation.builder()
                .moderationType(ModerationType.REPORT.getType())
                .reason(reason)
                .fromEnigmaUserId(authorities.getEnigmaUserId())
                .toEnigmaUserId(userId)
                .interestAreaId(interestAreaId)
                .postId(postId)
                .build();

        try {
            moderationRepository.save(moderation);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Could not save moderation.");
        }

        return moderation.getId();
    }

    /**
     * Get a list of moderations using the moderation service
     *
     * @param authorities       EnigmaAuthorities of the user
     * @param type              type of the moderation
     * @param interestAreaId    id of the interest area
     * @param postId            id of the post
     * @param toUserId          id of the user to be reported
     * @param fromUserId        id of the user who reported
     * @return                  list of moderations
     */
    @Override
    public List<ModerationDto> getModeration(EnigmaAuthorities authorities, ModerationType type, Long interestAreaId,
                                       Long postId, Long toUserId, Long fromUserId) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (type == null)
            throw new IllegalArgumentException("type cannot be null");

        List<Specification<Moderation>> specificationList = new ArrayList<>();
        specificationList.add(ModerationSpecification.isModerationType(type.getType()));
        if (interestAreaId != null)
            specificationList.add(ModerationSpecification.isInterestAreaId(interestAreaId));

        if (postId != null)
            specificationList.add(ModerationSpecification.isPostId(postId));

        if (toUserId != null)
            specificationList.add(ModerationSpecification.isToEnigmaUserId(toUserId));

        if (fromUserId != null)
            specificationList.add(ModerationSpecification.isFromEnigmaUserId(fromUserId));

        Specification<Moderation> specification = specificationList.get(0);
        for (int i = 1; i < specificationList.size(); i++)
            specification = specification.and(specificationList.get(i));

        List<Moderation> moderationList;
        try {
            moderationList = moderationRepository.findAll(specification);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch moderation.");
        }

        if (moderationList.isEmpty())
            return null;

        return moderationList.stream()
                .map(moderation ->
                        ModerationDto.builder()
                                .fromEnigmaUserId(moderation.getFromEnigmaUserId())
                                .toEnigmaUserId(moderation.getToEnigmaUserId())
                                .postId(moderation.getPostId())
                                .interestAreaId(moderation.getInterestAreaId())
                                .moderationType(moderation.getModerationType())
                                .reason(moderation.getReason())
                                .build())
                .collect(Collectors.toList());
    }

    /**
     * Initial check for moderation services
     *
     * @return interestAreaId
     */
    private Long initialCheck(EnigmaAuthorities authorities, Long userId, Long postId, String reason) {

        if (authorities == null)
            throw new IllegalArgumentException("authorities cannot be null");

        if (postId == null)
            throw new IllegalArgumentException("postId cannot be null");

        if (userId == null)
            throw new IllegalArgumentException("postId cannot be null");

        if (reason == null)
            throw new IllegalArgumentException("reason cannot be null");

        Long interestAreaId = postService.getInterestAreaIdOfPost(postId);
        if (authorities.getAudienceType() == AudienceType.USER)
            if (authorities.canModerate(interestAreaId))
                throw new IllegalArgumentException("Only moderators can unban users");

        return interestAreaId;
    }

}
