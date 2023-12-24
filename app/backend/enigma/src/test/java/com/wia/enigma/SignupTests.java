package com.wia.enigma;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.wia.enigma.core.data.request.SignupRequest;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaException;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.MediaType;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import static org.hamcrest.Matchers.containsString;
import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@RunWith(SpringRunner.class)
@AutoConfigureMockMvc(addFilters = false)
public class SignupTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EnigmaUserService enigmaUserService;

    @Test
    public void signup_success() throws Exception {

        RegisterResponse mockRegisterResponse = new RegisterResponse(1L, false);
        when(enigmaUserService.registerEnigmaUser(anyString(), anyString(), anyString(), anyString(), anyString()))
                .thenReturn(mockRegisterResponse);

        SignupRequest signupRequest = new SignupRequest(
                "username",
                "name",
                "email@example.com",
                "password",
                "2000-01-01"
        );

        mockMvc.perform(post("/api/auth/signup")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(asJsonString(signupRequest)))
                .andExpect(status().isCreated())
                .andExpect(header().string("Location", containsString("/api/v1/user/1")));
    }

    @Test
    public void signup_existingUsername() throws Exception {

        doThrow(new EnigmaException(ExceptionCodes.DB_UNIQUE_CONSTRAINT_VIOLATION,
                "EnigmaUser with username or email already exists."))
                .when(enigmaUserService).registerEnigmaUser(anyString(), anyString(), anyString(), anyString(), anyString());

        SignupRequest signupRequest = new SignupRequest(
                "existingUsername",
                "name",
                "email@example.com",
                "password",
                "2000-01-01"
        );

        mockMvc.perform(post("/api/auth/signup")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(asJsonString(signupRequest)))
                .andExpect(status().isBadRequest())
                .andExpect(content().string(containsString("EnigmaUser with username or email already exists.")));
    }

    @Test
    public void signup_badEmailUsername() throws Exception {

        SignupRequest signupRequest = new SignupRequest(
                "username@",
                "name",
                "badEmail",
                "password",
                "2000-01-01"
        );

        doThrow(new EnigmaException(ExceptionCodes.INVALID_USERNAME,
                "Username cannot contain '@'."))
                .when(enigmaUserService)
                .registerEnigmaUser(
                        "username@",
                        "name",
                        "badEmail",
                        "password",
                        "2000-01-01"
                );

        mockMvc.perform(post("/api/auth/signup")
                        .contentType(MediaType.APPLICATION_JSON)
                        .content(asJsonString(signupRequest)))
                .andExpect(status().isBadRequest())
                .andExpect(content().string(containsString("Username cannot contain '@'.")));
    }

    private static String asJsonString(final Object obj) {
        try {
            return new ObjectMapper().writeValueAsString(obj);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
