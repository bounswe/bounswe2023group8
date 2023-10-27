package com.wia.enigma.dal.repository;

import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.projection.EnigmaUserDetailsProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface EnigmaUserRepository extends JpaRepository<EnigmaUser, Long> {

    /*
        TODO: Implement this method

         username,
         password,
         id,
         audienceType,
         authorities (List<String>)
     */
    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false")
    EnigmaUserDetailsProjection findUserDetailsByUsername(String username);

    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END " +
            "FROM EnigmaUser e " +
            "WHERE ((:username IS NULL OR e.username = :username) " +
            "OR (:email IS NULL OR e.email = :email)) " +
            "AND e.isDeleted = false")
    boolean existsByUsernameOrEmail(String username, String email);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false")
    EnigmaUser findEnigmaUserByUsername(String username);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.email = ?1 AND u.isDeleted = false")
    EnigmaUser findEnigmaUserByEmail(String email);
}
