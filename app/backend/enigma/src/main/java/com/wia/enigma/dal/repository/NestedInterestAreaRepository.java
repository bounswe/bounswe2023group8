package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.NestedInterestArea;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface NestedInterestAreaRepository extends JpaRepository<NestedInterestArea, Long> {

    public List<NestedInterestArea> findAllByParentInterestAreaId(Long parentInterestAreaId);

    public void deleteAllByParentInterestAreaId(Long parentInterestAreaId);

}
