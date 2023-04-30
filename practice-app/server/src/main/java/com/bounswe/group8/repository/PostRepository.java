package com.bounswe.group8.repository;

import com.bounswe.group8.model.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepository extends JpaRepository<Post, Long> {

    Post findPostById(Long id);
}
