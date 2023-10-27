package com.wia.enigma.configuration.application;

import com.wia.enigma.utilities.JwtUtils;
import lombok.AccessLevel;
import lombok.experimental.FieldDefaults;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@FieldDefaults(level = AccessLevel.PRIVATE)
public class JwtSecretConfiguration {


    @Value("${jwt.secret}")
    private String jwtSecret;

    @Bean
    public JwtUtils jwtUtils() {
        return JwtUtils.initInstance(jwtSecret);
    }
}
