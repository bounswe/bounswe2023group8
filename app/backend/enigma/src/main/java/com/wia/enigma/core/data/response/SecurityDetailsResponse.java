package com.wia.enigma.core.data.response;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SecurityDetailsResponse {

    String tokenType;

    String accessToken;

    String refreshToken;

    Long expiresIn;
}
