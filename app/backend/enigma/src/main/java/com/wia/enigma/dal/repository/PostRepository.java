package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

public interface PostRepository  extends JpaRepository<Post, Long> {

    Post findPostById(Long id);

}