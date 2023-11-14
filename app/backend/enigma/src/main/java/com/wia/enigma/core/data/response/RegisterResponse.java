package com.wia.enigma.core.data.response;

import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.security.web.authentication.preauth.PreAuthenticatedAuthenticationToken;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class RegisterResponse {

    Long enigmaUserId;

    Boolean verified;
}
