package com.wia.enigma.dal.projection;

import java.util.List;

public interface EnigmaUserDetailsProjection {
    String getUsername();
    String getPassword();
    Long getId();
    String getAudienceType();
    List<String> getAuthorities();
}
