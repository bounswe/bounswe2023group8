package com.wia.enigma.core.service;

import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.dal.entity.EnigmaUser;

import java.sql.Date;

public interface EnigmaUserService {

    RegisterResponse registerEnigmaUser(String username,
                                        String email,
                                        String password,
                                        String birthday);

    LoginResponse loginEnigmaUser(String username, String password);

    void logoutEnigmaUser(String jwt);
}
