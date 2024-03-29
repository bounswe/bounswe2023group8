package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestAreaPost;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface InterestAreaPostRepository extends JpaRepository<InterestAreaPost, Long> {
    long deleteByPostId(Long postId);
    List<InterestAreaPost> findByPostId(Long postId);

    List<InterestAreaPost> findByInterestAreaIdIn(Collection<Long> interestAreaIds);

    List<InterestAreaPost> findByInterestAreaId(Long interestAreaId);

    void deleteAllByInterestAreaId(Long interestAreaId);

    void deleteAllByInterestAreaIdIn(Collection<Long> interestAreaIds);
}