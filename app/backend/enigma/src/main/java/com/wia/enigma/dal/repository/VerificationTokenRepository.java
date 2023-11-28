package com.wia.enigma.dal.repository;

import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.dal.entity.Post;
import com.wia.enigma.dal.entity.VerificationToken;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationTokenRepository extends JpaRepository<VerificationToken, Long> {

    VerificationToken findByTokenAndIsResetPasswordToken(String token, Boolean isResetPasswordToken);
}
