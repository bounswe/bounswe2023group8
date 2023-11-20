package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface InterestAreaRepository   extends JpaRepository<InterestArea, Long> {
    List<InterestArea> findByAccessLevelNotAndNameContainsOrIdIn(EnigmaAccessLevel accessLevel, String name, Collection<Long> ids);
    List<InterestArea> findByNameContainsOrIdInAndAccessLevelNot(String name, Collection<Long> ids, EnigmaAccessLevel accessLevel);
    List<InterestArea> findByNameContainsOrIdIn(String name, Collection<Long> ids);
    List<InterestArea> findByNameContains(String name);

    InterestArea findInterestAreaById(Long id);

    List<InterestArea> findAllByIdIn(List<Long> ids);

    @Query("SELECT COUNT(e) FROM InterestArea e WHERE e.id IN :ids")
    long countByIds(@Param("ids") List<Long> ids);

    default boolean existsAllByIdIsIn(List<Long> ids) {
        return ids.isEmpty() || ids.size() == countByIds(ids);
    }

}
