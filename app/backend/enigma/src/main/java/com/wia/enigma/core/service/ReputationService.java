package com.wia.enigma.core.service;


import com.wia.enigma.core.data.dto.ReputationVoteDto;
import com.wia.enigma.core.data.dto.UserBadgesDto;

public interface ReputationService {

    void voteOnUser(Long voterEnigmaUserId, Long votedEnigmaUserId, Integer vote, String comment);

    void voteOnPost(Long voterEnigmaUserId, Long postId, Integer vote, String comment);

    ReputationVoteDto getReputationVotesOfUser(Long enigmaUserId);

    UserBadgesDto getBadgesForUser(Long enigmaUserId);
}
