package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.projection.EnigmaUserDetailsProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Collection;
import java.util.List;

public interface EnigmaUserRepository extends JpaRepository<EnigmaUser, Long> {
    List<EnigmaUser> findByIdIn(Collection<Long> ids);
    @Query("SELECT u FROM EnigmaUser u WHERE u.isVerified = true AND (u.username LIKE %:username% OR u.name LIKE %:name%)")
    List<EnigmaUser> findByIsVerifiedTrueAndUsernameContainsOrNameContains(@Param("username") String username, @Param("name") String name);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.id= ?1 AND u.isVerified = false")
    EnigmaUser findEnigmaUserByNotVerified(Long id);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 ")
    EnigmaUserDetailsProjection findUserDetailsByUsername(String username);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.id= ?1 AND u.isVerified = true")
    EnigmaUser findEnigmaUserById(Long id);

    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END " +
            "FROM EnigmaUser e " +
            "WHERE ((:username IS NULL OR e.username = :username) " +
            "OR (:email IS NULL OR e.email = :email)) " +
            "AND e.isVerified = true")
    boolean existsByUsernameOrEmail(String username, String email);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isVerified = true")
    EnigmaUser findEnigmaUserByUsername(String username, Boolean isVerified);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.email = ?1 AND u.isVerified = true")
    EnigmaUser findEnigmaUserByEmail(String email);
}
