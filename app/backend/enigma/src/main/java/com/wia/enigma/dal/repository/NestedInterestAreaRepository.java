package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.NestedInterestArea;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Collection;
import java.util.List;

public interface NestedInterestAreaRepository extends JpaRepository<NestedInterestArea, Long> {

    List<NestedInterestArea> findByParentInterestAreaIdIn(Collection<Long> parentInterestAreaIds);

    List<NestedInterestArea> findAllByParentInterestAreaId(Long parentInterestAreaId);

    void deleteAllByParentInterestAreaId(Long parentInterestAreaId);
}
