package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EnigmaUser;
import org.springframework.data.jpa.repository.JpaRepository;

public interface EnigmaUserRepository extends JpaRepository<EnigmaUser, Long> {

    EnigmaUser findByUsername(String username);

}
