package com.wia.enigma;

import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaException;
import com.wia.enigma.utilities.JwtUtils;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.result.HeaderResultMatchers;

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@RunWith(SpringRunner.class)
@AutoConfigureMockMvc(addFilters = false)
public class LogoutTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EnigmaUserService enigmaUserService;

    @Test
    public void logout_invalidHeader() throws Exception {

        String authorizationHeader = "NotBearer someJwt";
        enigmaUserService.logoutEnigmaUser(authorizationHeader);

        doThrow(new EnigmaException(ExceptionCodes.INVALID_AUTHORIZATION_HEADER, "Invalid authorization header."))
                .when(enigmaUserService).logoutEnigmaUser(authorizationHeader);

        mockMvc.perform(post("/api/auth/logout")
                        .header(HttpHeaders.AUTHORIZATION, authorizationHeader))
                .andExpect(status().isUnauthorized());
    }

    @Test
    public void logout_invalidJwt() throws Exception {

        String authorizationHeader = "Bearer invalidJwt";
        enigmaUserService.logoutEnigmaUser(authorizationHeader);

        doThrow(new EnigmaException(ExceptionCodes.INVALID_JWT, "Invalid JWT."))
                .when(enigmaUserService).logoutEnigmaUser(authorizationHeader);

        mockMvc.perform(post("/api/auth/logout")
                        .header(HttpHeaders.AUTHORIZATION, authorizationHeader))
                .andExpect(status().isUnauthorized());
    }

    @Test
    public void logout_success() throws Exception {

        mockMvc.perform(post("/api/auth/logout")
                        .header(HttpHeaders.AUTHORIZATION, anyString()))
                .andExpect(status().isOk());
    }
}
