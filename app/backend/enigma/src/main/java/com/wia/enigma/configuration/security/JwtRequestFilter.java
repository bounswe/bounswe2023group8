package com.wia.enigma.configuration.security;

import com.wia.enigma.core.service.JwtService.EnigmaJwtService;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaException;
import com.wia.enigma.utilities.JwtUtils;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.lang.NonNull;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

@Slf4j
@RequiredArgsConstructor
public class JwtRequestFilter extends OncePerRequestFilter {

    final EnigmaJwtService enigmaJwtService;

    @Override
    protected void doFilterInternal(@NonNull HttpServletRequest request,
                                    @NonNull HttpServletResponse response,
                                    @NonNull FilterChain filterChain) throws ServletException, IOException {

        if (SecurityContextHolder.getContext().getAuthentication() != null) {
            filterChain.doFilter(request, response);
            return;
        }

        String authHeader = request.getHeader(HttpHeaders.AUTHORIZATION);
        if (authHeader == null) {
            throw new EnigmaException(ExceptionCodes.MISSING_AUTHORIZATION_HEADER,
                    "Missing Authorization header for request: {} {}".formatted(
                            request.getMethod(),
                            request.getRequestURI()
                    )
            );
        }

        if (!authHeader.startsWith(JwtUtils.getInstance().getTokenType())) {
            throw new EnigmaException(ExceptionCodes.INVALID_AUTHORIZATION_HEADER,
                    "Invalid Authorization header for request: {} {}".formatted(
                            request.getMethod(),
                            request.getRequestURI()
                    )
            );
        }

        String jwt = authHeader.substring(JwtUtils.getInstance().getTokenType().length() + 1).trim();
        EnigmaAuthenticationToken token = enigmaJwtService.validateJwt(jwt);

        token.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
        SecurityContextHolder.getContext().setAuthentication(token);
        setHeaders(response);

        filterChain.doFilter(request, response);
    }

    @Override
    protected boolean shouldNotFilter(HttpServletRequest request) {
        return (request.getRequestURI().startsWith("/api/auth")||
                request.getRequestURI().startsWith("/api/v1/explore")
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
