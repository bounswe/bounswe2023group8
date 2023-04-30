package com.bounswe.group8.repository;

import com.bounswe.group8.model.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface UserRepository extends JpaRepository<User, Long> {

    User findUserById(Long id);

    User findUserByUsername(String username);

    Boolean existsByUsername(String username);

}
