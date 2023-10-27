package com.wia.enigma.configuration.security;

import com.wia.enigma.dal.enums.AudienceType;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.FieldDefaults;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;

@Getter
@Setter
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserDetails extends User {

    /*
        type -> aud
        userId -> user_id
        username -> sub
        authorities -> authorities
    */

    AudienceType audienceType; // audience value

    Long enigmaUserId; // user id value

    public EnigmaUserDetails(String username,
                             String password,
                             Long userId,
                             AudienceType type,
                             Collection<? extends GrantedAuthority> authorities) {

        super(username, password, authorities);
        this.audienceType = type;
        this.enigmaUserId = userId;
    }

    @Override
    public String toString() {
        return "EnigmaUserDetails{" +
                "audienceType=" + audienceType +
                ", enigmaUserId=" + enigmaUserId +
                ", username=" + getUsername() +
                ", password=" + "[PROTECTED]" +
                ", authorities=" + getAuthorities() +
                '}';
    }
}
