package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface InterestAreaRepository   extends JpaRepository<InterestArea, Long> {
    List<InterestArea> findByAccessLevelInOrderByCreateTimeDesc(Collection<EnigmaAccessLevel> accessLevels);

    @Query("SELECT e FROM InterestArea e WHERE e.accessLevel <> :accessLevel AND (e.title LIKE %:title% OR e.id IN :ids)")
    List<InterestArea> findByAccessLevelNotAndTitleContainsOrIdIn(@Param("accessLevel") EnigmaAccessLevel accessLevel, @Param("title") String title, @Param("ids") List<Long> ids);

    InterestArea findInterestAreaById(Long id);

    List<InterestArea> findAllByIdIn(List<Long> ids);

    List<InterestArea> findAllByEnigmaUserId(Long enigmaUserId);
}
