package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.PostVote;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PostVoteRepository extends JpaRepository<PostVote, Long> {
    long countByPostIdAndVote(Long postId, Boolean vote);
    List<PostVote> findByPostId(Long postId);
    PostVote findByEnigmaUserIdAndPostId(Long enigmaUserId, Long postId);
    boolean existsByEnigmaUserIdAndPostId(Long enigmaUserId, Long postId);
    boolean existsByPostId(Long postId);
}
