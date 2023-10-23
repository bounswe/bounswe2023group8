package com.wia.enigma.configuration.security;

import com.wia.enigma.core.service.EnigmaJwtService;
import com.wia.enigma.utilities.AuthUtils;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.lang.NonNull;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;
import java.util.ArrayList;

@Slf4j
public class JwtRequestFilter extends OncePerRequestFilter {

    public static final String AUTHENTICATION_TYPE = "Bearer";

    EnigmaJwtService jwtService;

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {

        if (SecurityContextHolder.getContext().getAuthentication() != null) {
            filterChain.doFilter(request, response);
            return;
        }

        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader == null || !authHeader.startsWith(AUTHENTICATION_TYPE)) {

            log.error(
                    "Missing Authorization header for request: {} {}".formatted(
                            request.getMethod(),
                            request.getRequestURI()),
                    new BadCredentialsException("Missing Authorization header")
            );

            filterChain.doFilter(request, response);
            return;
        }

        String jwt = authHeader.substring(AUTHENTICATION_TYPE.length() + 1).trim();
        jwtService.validateJwt(jwt);

        Claims claims = jwtService.extractClaims(jwt);
        UsernamePasswordAuthenticationToken authentication = new UsernamePasswordAuthenticationToken(
                claims.getSubject(),
                null, // password is not needed, it's a JWT token
                new ArrayList<>() // empty authorities list for simplicity
        );

        authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(authentication);
        setHeaders(response);

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return (request.getRequestURI().startsWith("/auth")
                || request.getMethod().equals(HttpMethod.OPTIONS.name()));
    }


    /**
     * Sets the headers for the response
     *
     * @param response HttpServletResponse
     */
    private void setHeaders(HttpServletResponse response) {
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "GET, POST, PUT, DELETE, OPTIONS");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Authorization, X-Requested-With, Content-Length, Accept, Origin");
    }
}
