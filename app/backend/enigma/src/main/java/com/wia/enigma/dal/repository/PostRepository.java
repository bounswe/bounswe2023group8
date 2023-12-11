package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.enums.PostLabel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Collection;
import java.util.List;

public interface PostRepository  extends JpaRepository<Post, Long> {
    List<Post> findByTitleContainsOrContentContainsOrSourceLinkContains(String title, String content, String sourceLink);
    List<Post> findByTitleContainsOrContentContainsOrSourceLinkContainsOrLabel(String title, String content, String sourceLink, PostLabel label);
    List<Post> findByEnigmaUserIdIn(Collection<Long> enigmaUserIds);
    List<Post> findByEnigmaUserId(Long enigmaUserId);
    List<Post> findByIdIn(Collection<Long> ids);

    Post findPostById(Long id);

    @Query("SELECT P FROM Post P WHERE (P.enigmaUserId IN :enigmaUserIds AND P.accessLevel = com.wia.enigma.dal.enums.EnigmaAccessLevel.PUBLIC) OR (P.id IN :postIds)")
    List<Post> findByEnigmaUserIdInOrPostIdIn(Collection<Long> enigmaUserIds, Collection<Long> postIds);


}