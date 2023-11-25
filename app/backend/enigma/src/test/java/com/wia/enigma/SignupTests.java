//package com.wia.enigma;
//
//import com.wia.enigma.core.data.response.RegisterResponse;
//import com.wia.enigma.core.service.UserService.EnigmaUserService;
//import com.wia.enigma.dal.enums.ExceptionCodes;
//import com.wia.enigma.exceptions.custom.EnigmaException;
//import org.junit.Test;
//import org.junit.runner.RunWith;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
//import org.springframework.boot.test.context.SpringBootTest;
//import org.springframework.boot.test.mock.mockito.MockBean;
//import org.springframework.http.MediaType;
//import org.springframework.test.context.junit4.SpringRunner;
//import org.springframework.test.web.servlet.MockMvc;
//import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
//import org.springframework.test.web.servlet.result.MockMvcResultMatchers;
//
//import static org.hamcrest.Matchers.containsString;
//import static org.mockito.Mockito.*;
//import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
//import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;
//
//@RunWith(SpringRunner.class)
//@SpringBootTest
//@AutoConfigureMockMvc(addFilters = false)
//public class SignupTests {
//
//    @Autowired
//    private MockMvc mockMvc;
//
//    @MockBean
//    private EnigmaUserService enigmaUserService;
//
//    @Test
//    public void testSignup_ValidRequest_ShouldReturnCreated() throws Exception {
//        when(enigmaUserService.registerEnigmaUser(anyString(), anyString(), anyString(), anyString()))
//                .thenReturn(new RegisterResponse(1L, false));
//
//        mockMvc.perform(post("/auth/signup")
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .content("{\"username\":\"testUsername\",\"email\":\"test@email.com\",\"password\":\"testPassword\",\"birthday\":\"2000-01-01\"}"))
//                .andExpect(status().isCreated());
//    }
//
//    @Test
//    public void testSignup_UsernameContainsAtSymbol_ShouldReturnBadRequest() throws Exception {
//
//        String requestPayload = "{\"username\":\"test@Username\",\"email\":\"test@email.com\",\"password\":\"testPassword\",\"birthday\":\"2000-01-01\"}";
//
//        doThrow(new EnigmaException(ExceptionCodes.INVALID_USERNAME, "Username cannot contain '@'."))
//                .when(enigmaUserService).registerEnigmaUser(eq("test@Username"), anyString(), anyString(), anyString());
//
//        mockMvc.perform(MockMvcRequestBuilders.post("/auth/signup")
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .content(requestPayload))
//                .andExpect(MockMvcResultMatchers.status().isBadRequest())
//                .andExpect(MockMvcResultMatchers.content().string(containsString("Username cannot contain '@'.")));
//    }
//
//    @Test
//    public void testSignup_InvalidBirthdayFormat_ShouldReturnBadRequest() throws Exception {
//        String invalidBirthdayPayload = "{\"username\":\"testUsername\",\"email\":\"test@email.com\",\"password\":\"testPassword\",\"birthday\":\"invalidDate\"}";
//
//        doThrow(new EnigmaException(ExceptionCodes.INVALID_DATE_FORMAT, "Birthday is not in the correct format. Use \"yyyy-[m]m-[d]d\""))
//                .when(enigmaUserService).registerEnigmaUser(anyString(), anyString(), anyString(), anyString());
//
//        mockMvc.perform(post("/auth/signup")
//                        .contentType(MediaType.APPLICATION_JSON)
//                        .content(invalidBirthdayPayload))
//                .andExpect(status().isBadRequest())
//                .andExpect(content().string(containsString("Birthday is not in the correct format".trim())));
//    }
//
//}
