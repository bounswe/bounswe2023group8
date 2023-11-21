package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestArea;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface InterestAreaRepository   extends JpaRepository<InterestArea, Long> {

    InterestArea findInterestAreaById(Long id);

    List<InterestArea> findAllByIdIn(List<Long> ids);

    @Query("SELECT COUNT(e) FROM InterestArea e WHERE e.id IN :ids")
    long countByIds(@Param("ids") List<Long> ids);

    default boolean existsAllByIdIsIn(List<Long> ids) {
        return ids.isEmpty() || ids.size() == countByIds(ids);
    }

}
