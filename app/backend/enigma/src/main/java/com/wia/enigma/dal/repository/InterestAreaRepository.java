package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.InterestArea;
import org.springframework.data.jpa.repository.JpaRepository;

public interface InterestAreaRepository   extends JpaRepository<InterestArea, Long> {

    InterestArea findInterestAreaById(Long id);
}
