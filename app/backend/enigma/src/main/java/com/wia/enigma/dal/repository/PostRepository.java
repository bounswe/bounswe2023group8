package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.Post;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface PostRepository  extends JpaRepository<Post, Long> {
    List<Post> findByIdIn(Collection<Long> ids);

    Post findPostById(Long id);

}