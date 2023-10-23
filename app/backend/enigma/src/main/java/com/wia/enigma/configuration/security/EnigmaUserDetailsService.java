package com.wia.enigma.configuration.security;

import com.wia.enigma.dal.entity.EnigmaUser;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserDetailsService implements UserDetailsService {
    final EnigmaUserRepository userRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        // Fetch the user from the database using the repository
        EnigmaUser enigmaUser = userRepository.findByUsername(username);

        if(enigmaUser == null) {
            throw new UsernameNotFoundException("User not found: " + username);
        }

        // Convert the EnigmaUser entity to Spring's User object
        return new User(enigmaUser.getUsername(), enigmaUser.getPassword(), new ArrayList<>()); // empty authorities list for simplicity
    }
}