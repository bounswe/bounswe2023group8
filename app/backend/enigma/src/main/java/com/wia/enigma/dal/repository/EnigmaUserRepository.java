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
            "WHERE u.id= ?1 AND u.isDeleted = false AND u.isVerified = ?2")
    EnigmaUser findByIdAndIsVerified(Long id, Boolean isVerified);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false")
    EnigmaUserDetailsProjection findUserDetailsByUsername(String username);

    @Query("SELECT CASE WHEN COUNT(e) > 0 THEN true ELSE false END " +
            "FROM EnigmaUser e " +
            "WHERE ((:username IS NULL OR e.username = :username) " +
            "OR (:email IS NULL OR e.email = :email)) " +
            "AND e.isDeleted = false AND e.isVerified = :isVerified")
    boolean existsByUsernameOrEmailAAndIsVerified(String username, String email, Boolean isVerified);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.username = ?1 AND u.isDeleted = false AND u.isVerified = ?2")
    EnigmaUser findEnigmaUserByUsernameAndIsVerified(String username, Boolean isVerified);

    @Query("SELECT u " +
            "FROM EnigmaUser u " +
            "WHERE u.email = ?1 AND u.isDeleted = false AND u.isVerified = ?2")
    EnigmaUser findEnigmaUserByEmailAndIsVerified(String email, Boolean isVerified);
}
