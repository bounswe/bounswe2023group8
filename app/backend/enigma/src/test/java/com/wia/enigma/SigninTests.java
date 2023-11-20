package com.wia.enigma;

import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.SecurityDetailsResponse;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaBadRequestException;
import com.wia.enigma.exceptions.custom.EnigmaUnauthorizedException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc(addFilters = false)
public class SigninTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EnigmaUserService enigmaUserService;

    @Test
    public void testSignin_ValidCredentials_ShouldReturnOk() throws Exception {
        SecurityDetailsResponse securityDetailsResponse = SecurityDetailsResponse.builder()
                .tokenType("Bearer")
                .accessToken("mockAccessToken12345")
                .refreshToken("mockRefreshToken12345")
                .expiresIn(3600L)
                .build();

        LoginResponse mockLoginResponse = LoginResponse.builder()
                .authentication(securityDetailsResponse)
                .build();

        when(enigmaUserService.loginEnigmaUser("testUsername", "testPassword")).thenReturn(mockLoginResponse);

        mockMvc.perform(get("/auth/signin")
                        .param("user", "testUsername")
                        .param("password", "testPassword"))
                .andExpect(status().isOk())
                .andExpect(jsonPath("$.authentication.tokenType").value("Bearer"))
                .andExpect(jsonPath("$.authentication.accessToken").value("mockAccessToken12345"))
                .andExpect(jsonPath("$.authentication.refreshToken").value("mockRefreshToken12345"))
                .andExpect(jsonPath("$.authentication.expiresIn").value(3600));
    }


    @Test
    public void testSignin_InvalidUsernameOrEmail_ShouldReturnBadRequest() throws Exception {
        when(enigmaUserService.loginEnigmaUser("invalidUsername", "testPassword"))
                .thenThrow(new EnigmaBadRequestException(ExceptionCodes.USER_NOT_FOUND, "EnigmaUser not found for username or email: invalidUsername"));

        mockMvc.perform(get("/auth/signin")
                        .param("user", "invalidUsername")
                        .param("password", "testPassword"))
                .andExpect(status().isBadRequest())
                .andExpect(content().string(containsString("EnigmaUser not found for username or email: invalidUsername")));
    }

    @Test
    public void testSignin_InvalidPassword_ShouldReturnUnauthorized() throws Exception {
        when(enigmaUserService.loginEnigmaUser("testUsername", "invalidPassword"))
                .thenThrow(new EnigmaUnauthorizedException(ExceptionCodes.INVALID_PASSWORD, "Password is not valid."));

        mockMvc.perform(get("/auth/signin")
                        .param("user", "testUsername")
                        .param("password", "invalidPassword"))
                .andExpect(status().isUnauthorized())
                .andExpect(content().string(containsString("Password is not valid.")));
    }

}
