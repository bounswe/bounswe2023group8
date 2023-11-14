package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EnigmaJwt;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EnigmaJwtRepository extends JpaRepository<EnigmaJwt, Long> {

    EnigmaJwt findEnigmaJwtById(Long id);
}
