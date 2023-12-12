package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.enums.PostLabel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PostRepository  extends JpaRepository<Post, Long> {

    List<Post> findByTitleContainsOrContentContainsOrSourceLinkContains(String title, String content, String sourceLink);

    List<Post> findByEnigmaUserId(Long enigmaUserId);

    @Query("SELECT P FROM Post P WHERE (P.enigmaUserId IN :enigmaUserIds AND P.accessLevel = com.wia.enigma.dal.enums.EnigmaAccessLevel.PUBLIC) OR (P.id IN :postIds)")
    List<Post> findByEnigmaUserIdInOrPostIdIn(Collection<Long> enigmaUserIds, Collection<Long> postIds);

    void deleteAllByEnigmaUserId(Long enigmaUserId);

    Integer countAllByEnigmaUserId(Long enigmaUserId);
}