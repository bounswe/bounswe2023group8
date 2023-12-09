package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;
import java.util.Set;

public interface EntityTagsRepository extends JpaRepository<EntityTag, Long> {

    List<EntityTag> findByEntityIdInAndEntityType(Collection<Long> entityIds, EntityType entityType);

    List<EntityTag> findByWikiDataTagIdInAndEntityType(Collection<String> wikiDataTagIds, EntityType entityType);

    List<EntityTag> findAllByEntityIdAndEntityType(Long entityId, EntityType entityType);

    void deleteAllByEntityIdAndEntityType(Long entityId, EntityType entityType);

    void deleteAllByEntityIdInAndEntityType(Set<Long> entityIds, EntityType entityType);
}
