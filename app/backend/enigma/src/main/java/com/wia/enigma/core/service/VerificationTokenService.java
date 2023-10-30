package com.wia.enigma.core.service;

import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.dal.entity.VerificationToken;

public interface VerificationTokenService {

    VerificationToken createVerificationToken(Long enigmaUserId, Boolean isResetPasswordToken);

    VerificationToken verifyToken(String token, Boolean isResetPasswordToken);

    void save (VerificationToken verificationToken);

    void revoke(VerificationToken verificationToken);
}