package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface InterestAreaRepository   extends JpaRepository<InterestArea, Long> {
    long countByIdAndAccessLevel(Long id, EnigmaAccessLevel accessLevel);
    List<InterestArea> findByIdIn(Collection<Long> ids);

    @Query("SELECT e FROM InterestArea e WHERE e.accessLevel <> :accessLevel AND (e.title LIKE %:title% OR e.id IN :ids)")
    List<InterestArea> findByAccessLevelNotAndTitleContainsOrIdIn(@Param("accessLevel") EnigmaAccessLevel accessLevel, @Param("title") String title, @Param("ids") List<Long> ids);

    InterestArea findInterestAreaById(Long id);

    List<InterestArea> findAllByIdIn(List<Long> ids);

    @Query("SELECT COUNT(e) FROM InterestArea e WHERE e.id IN :ids")
    long countByIds(@Param("ids") List<Long> ids);

    default boolean existsAllByIdIsIn(List<Long> ids) {
        return ids.isEmpty() || ids.size() == countByIds(ids);
    }

}
