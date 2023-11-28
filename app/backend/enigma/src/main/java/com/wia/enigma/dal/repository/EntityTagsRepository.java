package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface EntityTagsRepository extends JpaRepository<EntityTag, Long> {
    List<EntityTag> findByEntityIdInAndEntityType(Collection<Long> entityIds, EntityType entityType);
    List<EntityTag> findByWikiDataTagIdInAndEntityType(Collection<String> wikiDataTagIds, EntityType entityType);
    List<EntityTag> findByWikiDataTagIdIn(Collection<String> wikiDataTagIds);

    public List<EntityTag> findAllByEntityIdAndEntityType(Long entityId, EntityType entityType);

    public void deleteAllByEntityIdAndEntityType(Long entityId, EntityType entityType);

}
