package com.bounswe.group8.Location;

import com.bounswe.group8.controller.LocationController;
import com.bounswe.group8.model.Location;
import com.bounswe.group8.payload.LocationCreateRequest;
import com.bounswe.group8.service.LocationService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.RequestBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;

import static org.junit.jupiter.api.Assertions.assertEquals;

@ExtendWith(SpringExtension.class)
@WebMvcTest(value = LocationController.class)
public class LocationControllerTest {

    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private LocationService locationService;

    @Test
    public void createLocationTest() throws Exception {

        String mockLocationJson = "{\"latitude\":1.5,\"longitude\":2.5,\"address\":\"mock address no:5\",\"title\":\"mock witty title\"}";
        Location mockLocation = new Location(123321L, 1.5, 2.5, "mock address no:5", "mock witty title");

        Mockito.when(locationService.createLocation(Mockito.any(LocationCreateRequest.class)))
                .thenReturn(mockLocation);

        RequestBuilder requestBuilder = MockMvcRequestBuilders
                .post("/api/location")
                .accept(MediaType.APPLICATION_JSON).content(mockLocationJson)
                .contentType(MediaType.APPLICATION_JSON);

        MvcResult result = mockMvc.perform(requestBuilder).andReturn();

        MockHttpServletResponse response = result.getResponse();

        assertEquals(HttpStatus.CREATED.value(), response.getStatus());

        assertEquals(
                "http://localhost/api/location/" + mockLocation.getId(),
                response.getHeader(HttpHeaders.LOCATION));

    }

    @Test
    public void getCountByTitleTest() throws Exception {

        int mockCount = 5;
        String mockTitle = "Mock Title";

        Mockito.when(locationService.countEntriesForTitle(Mockito.anyString()))
                .thenReturn(mockCount);

        RequestBuilder requestBuilder = MockMvcRequestBuilders
                .get("/api/location/" + mockTitle + "/count")
                .accept(MediaType.APPLICATION_JSON);

        MvcResult result = mockMvc.perform(requestBuilder).andReturn();

        MockHttpServletResponse response = result.getResponse();

        assertEquals(Integer.toString(mockCount),response.getContentAsString());

    }


}
