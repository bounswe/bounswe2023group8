package com.wia.enigma.configuration.security;

import com.wia.enigma.dal.enums.AudienceType;
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

    Long enigmaUserId;

    AudienceType audienceType;

    Long jti;

    public EnigmaAuthenticationToken(Object principal,
                                     Object credentials,
                                     Long enigmaUserId,
                                     AudienceType audienceType,
                                     Long jti,
                                     Collection<? extends GrantedAuthority> authorities) {

        super(principal, credentials, authorities);
        this.enigmaUserId = enigmaUserId;
        this.audienceType = audienceType;
        this.jti = jti;
    }
}
