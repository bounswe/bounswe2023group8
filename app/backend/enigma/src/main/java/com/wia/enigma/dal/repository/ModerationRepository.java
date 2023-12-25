package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.Moderation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface ModerationRepository extends JpaRepository<Moderation, Long>, JpaSpecificationExecutor<Moderation> {

    void deleteAllByToEnigmaUserIdAndInterestAreaIdAndModerationType(Long userId, Long interestAreaId, String type);
}
