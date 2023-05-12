package com.bounswe.group8.service;

import com.bounswe.group8.mapper.LocationMapper;
import com.bounswe.group8.model.Location;
import com.bounswe.group8.payload.LocationCreateRequest;
import com.bounswe.group8.payload.dto.LocationDto;
import com.bounswe.group8.repository.LocationRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LocationService {

    final LocationRepository locationRepository;

    /**
     * Create a new location in the database
     *
     * @param request   LocationCreateRequest
     * @return          Saved location
     */
    public Location createLocation(LocationCreateRequest request) {

        Location location = Location.builder()
                .latitude(request.getLatitude())
                .longitude(request.getLongitude())
                .address(request.getAddress())
                .title(request.getTitle())
                .build();

        return locationRepository.save(location);

    }

    /**
     *
     * @param title Title under which locations are saved
     * @return      List of locations.
     */
    public List<LocationDto> getLocationsByTitle(String title){

        List<Location> locations = locationRepository.findLocationsByTitle(title);

        return locations.stream().map(LocationMapper::locationToLocationDto).toList();

    }

    /**
     * Count number of entries under a title
     *
     * @param title     Title under which locations are saved
     * @return          Number of entries
     */
    public int countEntriesForTitle(String title) {
        return locationRepository.countByTitle(title);
    }
}
