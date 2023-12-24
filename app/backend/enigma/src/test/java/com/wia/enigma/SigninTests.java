package com.wia.enigma;

import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.SecurityDetailsResponse;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import java.util.Objects;

import static org.hamcrest.Matchers.containsString;
import static org.junit.Assert.assertTrue;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@RunWith(SpringRunner.class)
@AutoConfigureMockMvc(addFilters = false)
public class SigninTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EnigmaUserService enigmaUserService;

    @Test
    public void signin_success() throws Exception {

        SecurityDetailsResponse securityDetailsResponse = SecurityDetailsResponse.builder()
                .tokenType("Bearer")
                .accessToken("mockAccessToken12345")
                .refreshToken("mockRefreshToken12345")
                .expiresIn(3600L)
                .build();

        LoginResponse mockLoginResponse = LoginResponse.builder()
                .authentication(securityDetailsResponse)
                .build();

        when(enigmaUserService.loginEnigmaUser(anyString(), anyString())).thenReturn(mockLoginResponse);

        mockMvc.perform(get("/api/auth/signin")
                        .param("user", "username")
                        .param("password", "password"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.authentication.tokenType").value("Bearer"))
                .andExpect(jsonPath("$.authentication.accessToken").value("mockAccessToken12345"))
                .andExpect(jsonPath("$.authentication.refreshToken").value("mockRefreshToken12345"))
                .andExpect(jsonPath("$.authentication.expiresIn").value(3600));
    }

    @Test
    public void signin_missingUsernameOrEmail() throws Exception {
        mockMvc.perform(get("/api/auth/signin")
                        .param("password", "password"))
                .andExpect(status().isBadRequest())
                .andExpect(result -> assertTrue(Objects.requireNonNull(result.getResponse().getErrorMessage()).contains("Required parameter 'user' is not present")));
    }

    @Test
    public void signin_userNotFound() throws Exception {

        when(enigmaUserService.loginEnigmaUser(anyString(), anyString()))
                .thenThrow(new EnigmaException(ExceptionCodes.USER_NOT_FOUND, "EnigmaUser not found for username or email: username"));

        mockMvc.perform(get("/api/auth/signin")
                        .param("user", "username")
                        .param("password", "password"))
                .andExpect(status().isNotFound())
                .andExpect(content().string(containsString("EnigmaUser not found for username or email: username")));
    }

    @Test
    public void signin_invalidPassword() throws Exception {

        when(enigmaUserService.loginEnigmaUser(anyString(), anyString()))
                .thenThrow(new EnigmaException(ExceptionCodes.INVALID_PASSWORD, "Password is not valid."));

        mockMvc.perform(get("/api/auth/signin")
                        .param("user", "username")
                        .param("password", "password"))
                .andExpect(status().isBadRequest())
                .andExpect(content().string(containsString("Password is not valid.")));
    }
}
