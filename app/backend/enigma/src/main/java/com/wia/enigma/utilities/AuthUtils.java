package com.wia.enigma.utilities;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.EnigmaAuthorities;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

@FieldDefaults(level = AccessLevel.PRIVATE)
public class AuthUtils {

    static AuthUtils instance;

    /**
     * Get the instance of the AuthUtils class.
     * Singleton pattern.
     *
     * @return AuthUtils
     */
    public static AuthUtils getInstance() {
        if (instance == null) instance = new AuthUtils();
        return instance;
    }

    public Collection<? extends GrantedAuthority> buildAuthorities(Object authorities) {
        List<String> castAuthorities;
        try {
            castAuthorities = (List<String>) authorities;
        } catch (ClassCastException e) {
            throw new BadCredentialsException("Invalid JWT token. Authorities are not the expected type");
        }

        return castAuthorities.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    public Collection<? extends GrantedAuthority> getAuthorities(List<String> authorities) {
        return authorities.stream()
                .map(SimpleGrantedAuthority::new)
                .collect(Collectors.toList());
    }

    public List<String> getAuthorities(Collection<? extends GrantedAuthority> authorities) {
        return authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .collect(Collectors.toList());
    }

    public EnigmaAuthorities buildEnigmaAuthorities(EnigmaAuthenticationToken token) {

        return EnigmaAuthorities.builder()
                .enigmaUserId(token.getEnigmaUserId())
                .audienceType(token.getAudienceType())
                .build();
    }
}
