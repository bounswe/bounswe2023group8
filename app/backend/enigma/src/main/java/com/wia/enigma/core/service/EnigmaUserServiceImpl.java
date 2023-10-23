package com.wia.enigma.core.service;

import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserServiceImpl implements EnigmaUserService {

    final EnigmaUserRepository userRepository;

    /**
     * Gets the EnigmaUser by username.
     *
     * @param username EnigmaUser.username
     * @return EnigmaUser
     */
    @Override
    public EnigmaUser getEnigmaUserByUsername(String username) {

        EnigmaUser enigmaUser = null;
        try {
            enigmaUser = userRepository.findByUsername(username);
        } catch (Exception e) {
            log.error("Error getting EnigmaUser by username: " + username);
        }

        if (enigmaUser == null)
            throw new RuntimeException("EnigmaUser not found! (username:" + username + ")");

        return enigmaUser;
    }
}
