package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.ReputationVote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReputationVoteRepository extends JpaRepository<ReputationVote, Long> {
    List<ReputationVote> findByVoterEnigmaUserIdOrVotedEnigmaUserId(Long voterEnigmaUserId, Long votedEnigmaUserId);

    List<ReputationVote> findAllByVoterEnigmaUserId(Long voterEnigmaUserId);

    ReputationVote findByVoterEnigmaUserIdAndVotedEnigmaUserId(Long voterEnigmaUserId, Long votedEnigmaUserId);

    List<ReputationVote> findAllByVotedEnigmaUserId(Long enigmaUserId);
}
