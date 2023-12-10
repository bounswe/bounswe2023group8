package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.PostComment;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface PostCommentRepository extends JpaRepository<PostComment, Long> {
    long countByPostId(Long postId);
    List<PostComment> findByPostId(Long postId);

}
