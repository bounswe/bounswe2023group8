package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.TagSuggestion;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TagSuggestionRepository extends JpaRepository<TagSuggestion, Long> {
    List<TagSuggestion> findByEntityIdAndEntityType(Long entityId, EntityType entityType);
}
