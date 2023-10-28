package com.wia.enigma.core.service;

import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.VerificationResponse;
import com.wia.enigma.dal.entity.EnigmaUser;

import java.sql.Date;

public interface EnigmaUserService {

    void registerEnigmaUser(String username,
                                        String email,
                                        String password,
                                        String birthday);

    LoginResponse loginEnigmaUser(String username, String password);

    void logoutEnigmaUser(String jwt);

    VerificationResponse verifyEnigmaUser(String token);

    void forgotPassword(String email);
    void resetPassword(String token, String newPassword1, String newPassword2);

}
