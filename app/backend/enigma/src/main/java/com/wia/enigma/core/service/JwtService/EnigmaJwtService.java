package com.wia.enigma.core.service.JwtService;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.configuration.security.EnigmaUserDetails;
import com.wia.enigma.core.data.dto.JwtGenerationDto;
import io.jsonwebtoken.Claims;
import org.springframework.data.util.Pair;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.List;

public interface EnigmaJwtService {

    EnigmaAuthenticationToken validateJwt(String jwt);

    JwtGenerationDto generateToken(Long enigmaUserId,
                                   String username,
                                   List<String> authorities,
                                   String audienceValue,
                                   Boolean isRefreshToken);

    Pair<JwtGenerationDto, JwtGenerationDto> generateTokens(Long enigmaUserId,
                                                            String username,
                                                            List<String> authorities,
                                                            String audienceValue);

    void revokeToken(Long enigmaJwtId);
}
