package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EntityTag;
import com.wia.enigma.dal.enums.EntityType;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface EntityTagsRepository extends JpaRepository<EntityTag, Long> {

    public List<EntityTag> findAllByEntityIdAndEntityType(Long entityId, EntityType entityType);

}
