package com.wia.enigma.core.service;

import com.wia.enigma.core.data.dto.EnigmaAuthorities;
import com.wia.enigma.core.data.dto.ModerationDto;
import com.wia.enigma.dal.enums.ModerationType;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface ModerationService {

    void removePost(EnigmaAuthorities authorities, Long postId);

    void removeInterestArea(EnigmaAuthorities authorities, Long interestAreaId);

    Long warnUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason);

    Long banUser(EnigmaAuthorities authorities, Long userId, Long postId, String reason);

    @Transactional
    void unbanUser(EnigmaAuthorities authorities, Long userId, Long interestAreaId);

    Long reportIssue(EnigmaAuthorities authorities, Long userId, Long postId, Long interestAreaId, String reason);

    List<ModerationDto> getModeration(EnigmaAuthorities authorities, ModerationType type, Long interestAreaId,
                                      Long postId, Long toUserId, Long fromUserId);
}
