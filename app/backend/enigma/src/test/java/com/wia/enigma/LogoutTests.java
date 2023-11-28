package com.wia.enigma;

import com.wia.enigma.core.service.UserService.EnigmaUserService;
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

import static org.mockito.Mockito.*;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@SpringBootTest
@AutoConfigureMockMvc(addFilters = false)
public class LogoutTests {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private EnigmaUserService enigmaUserService;

    @MockBean
    private JwtUtils jwtUtils;

    @Test
    public void testLogout_ValidJwt_ShouldReturnOk() throws Exception {
        when(jwtUtils.getTokenType()).thenReturn("Bearer");
        when(jwtUtils.assertValidJwt(anyString())).thenReturn("123456"); // Mocking a valid JTI return

        mockMvc.perform(post("/auth/logout")
                        .header(HttpHeaders.AUTHORIZATION, "Bearer validJwtToken123"))
                .andExpect(status().isOk());
    }

}
