package com.bounswe.group8.Location;

import com.bounswe.group8.model.Location;
import com.bounswe.group8.payload.LocationCreateRequest;
import com.bounswe.group8.payload.dto.LocationDto;
import com.bounswe.group8.repository.LocationRepository;
import com.bounswe.group8.service.LocationService;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;

@ExtendWith(SpringExtension.class)
public class LocationServiceTest {


    @Mock
    private LocationRepository locationRepository;

    @InjectMocks
    private LocationService locationService;

    @Test
    public void createLocationTest(){

        LocationCreateRequest mockRequest = new LocationCreateRequest()
                .setLatitude(11.1)
                .setLongitude(11.1)
                .setAddress("address 1")
                .setTitle("title 1");

        Location expectedSavedLocation = new Location(
                1L,
                11.1,
                11.1,
                "address 1",
                "title 1");

        Mockito.when(locationRepository.save(Mockito.any(Location.class)))
                .thenReturn(expectedSavedLocation);

        assertEquals(expectedSavedLocation, locationService.createLocation(mockRequest));

    }

    @Test
    public void getLocationByTitleTest(){

        String mockTitle = "title 1";

        List<Location> mockLocationList = new ArrayList<>();
        mockLocationList.add(new Location(
                1L,
                11.1,
                11.1,
                "address 1",
                "title 1"));
        mockLocationList.add(new Location(
                2L,
                22.2,
                22.2,
                "address 2",
                "title 2"));


        Mockito.when(locationRepository.findLocationsByTitle(mockTitle))
                .thenReturn(mockLocationList);

        List<LocationDto> expectedLocationListDto = new ArrayList<>();
        expectedLocationListDto.add(new LocationDto(
                "location",
                1L,
                11.1,
                11.1,
                "address 1",
                "title 1"));
        expectedLocationListDto.add(new LocationDto(
                "location",
                2L,
                22.2,
                22.2,
                "address 2",
                "title 2"));

        List<LocationDto> resultingList = locationService.getLocationsByTitle(mockTitle);

        for (int i = 0; i < 2; i++) {
            assertEquals(expectedLocationListDto.get(i).getType(), resultingList.get(i).getType());
            assertEquals(expectedLocationListDto.get(i).getLatitude(), resultingList.get(i).getLatitude());
            assertEquals(expectedLocationListDto.get(i).getAddress(), resultingList.get(i).getAddress());
        }
    }

    @Test
    public void countEntriesForTitle(){

        String mockTitle = "title 1";
        int mockCount = 5;
        int expectedCount = 5;

        Mockito.when(locationRepository.countByTitle(Mockito.anyString()))
                .thenReturn(mockCount);

        assertEquals(expectedCount, locationService.countEntriesForTitle(mockTitle));

    }

}
