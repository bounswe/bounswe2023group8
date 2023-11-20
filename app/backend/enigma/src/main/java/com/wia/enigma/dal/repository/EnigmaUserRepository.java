package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.projection.EnigmaUserDetailsProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface EnigmaUserRepository extends JpaRepository<EnigmaUser, Long> {
    List<EnigmaUser> findByIsVerifiedTrueAndUsernameContainsOrNameContains(String username, String name);
    List<EnigmaUser> findByUsernameContainsOrNameContainsAndIsVerified(String username, String name, Boolean isVerified);
    List<EnigmaUser> findByUsernameContainsOrNameContains(String username, String name);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.id= ?1 AND u.isDeleted = false AND u.isVerified = false")
    EnigmaUser findEnigmaUserByNotVerified(Long id);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false")
    EnigmaUserDetailsProjection findUserDetailsByUsername(String username);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.id= ?1 AND u.isDeleted = false AND u.isVerified = true")
    EnigmaUser findEnigmaUserById(Long id);

    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END " +
            "FROM EnigmaUser e " +
            "WHERE ((:username IS NULL OR e.username = :username) " +
            "OR (:email IS NULL OR e.email = :email)) " +
            "AND e.isDeleted = false AND e.isVerified = true")
    boolean existsByUsernameOrEmail(String username, String email);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false AND u.isVerified = true")
    EnigmaUser findEnigmaUserByUsername(String username, Boolean isVerified);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.email = ?1 AND u.isDeleted = false AND u.isVerified = true")
    EnigmaUser findEnigmaUserByEmail(String email);
}
