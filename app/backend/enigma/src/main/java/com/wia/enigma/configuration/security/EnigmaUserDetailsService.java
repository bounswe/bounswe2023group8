package com.wia.enigma.configuration.security;

import com.wia.enigma.dal.enums.AudienceType;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.projection.EnigmaUserDetailsProjection;
import com.wia.enigma.dal.repository.EnigmaUserRepository;
import com.wia.enigma.exceptions.custom.EnigmaDatabaseException;
import com.wia.enigma.utilities.AuthUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserDetailsService implements UserDetailsService {

    final EnigmaUserRepository userRepository;

    @Override
    public EnigmaUserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        EnigmaUserDetailsProjection enigmaUser;
        try {
            enigmaUser = userRepository.findUserDetailsByUsername(username);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaDatabaseException(ExceptionCodes.DB_GET_ERROR,
                    "Error while fetching user details from database.");
        }

        if (enigmaUser == null)
            throw new UsernameNotFoundException("EnigmaUser with username " + username + " not found.");

        return new EnigmaUserDetails(
                enigmaUser.getUsername(),
                enigmaUser.getPassword(),
                enigmaUser.getId(),
                AudienceType.fromString(enigmaUser.getAudienceType()),
                AuthUtils.getInstance().buildAuthorities(enigmaUser.getAuthorities())
        );
    }
}