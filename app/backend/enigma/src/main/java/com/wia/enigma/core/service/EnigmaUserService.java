package com.wia.enigma.core.service;

import com.wia.enigma.dal.entity.EnigmaUser;

public interface EnigmaUserService {
    EnigmaUser getEnigmaUserByUsername(String username);
}
