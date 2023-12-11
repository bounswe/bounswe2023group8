package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.WikiTag;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface WikiTagRepository extends JpaRepository<WikiTag, String> {
    List<WikiTag> findByIdIn(Collection<String> ids);
    List<WikiTag> findByLabelContainsOrDescriptionContains(String label, String description);
}
