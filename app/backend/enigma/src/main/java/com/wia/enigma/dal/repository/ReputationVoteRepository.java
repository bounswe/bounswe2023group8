package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.ReputationVote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ReputationVoteRepository extends JpaRepository<ReputationVote, Long> {

    List<ReputationVote> findAllByVoterEnigmaUserId(Long voterEnigmaUserId);
}
