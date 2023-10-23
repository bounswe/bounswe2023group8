package com.wia.enigma.configuration.security;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

@Getter
@Setter
@ToString
public class EnigmaAuthenticationToken extends UsernamePasswordAuthenticationToken {

    Long enigmaUserId; // EnigmaUserId

    public EnigmaAuthenticationToken(Object principal,
                                     Object credentials,
                                     Long enigmaUserId,
                                     Collection<? extends GrantedAuthority> authorities) {

        super(principal, credentials, authorities);
        this.enigmaUserId = enigmaUserId;
    }
}
