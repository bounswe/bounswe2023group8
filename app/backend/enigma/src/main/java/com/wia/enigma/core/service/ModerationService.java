package com.wia.enigma.core.service;

import com.wia.enigma.core.data.dto.EnigmaAuthorities;
import com.wia.enigma.core.data.dto.ModerationDto;
import com.wia.enigma.dal.enums.EntityType;
import com.wia.enigma.dal.enums.ModerationType;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ModerationService {

    void removePost(EnigmaAuthorities authorities, Long postId);

    void removeInterestArea(EnigmaAuthorities authorities, Long interestAreaId);

    void warnUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason);

    void banUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason);

    @Transactional
    void unbanUser(EnigmaAuthorities authorities, Long userId, Long interestAreaId);

    void reportIssue(EnigmaAuthorities authorities, EntityType entityType, Long entityId, String reason);

    List<ModerationDto> getModeration(EnigmaAuthorities authorities, ModerationType type, Long interestAreaId,
                                      Long postId, Long toUserId, Long fromUserId);
}
