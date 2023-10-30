package com.wia.enigma.core.data.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;

@Data
@Builder
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RegisterResponse {

    Long enigmaUserId;

    Boolean verified;
}
