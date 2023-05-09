package com.bounswe.group8.controller;

import com.bounswe.group8.payload.LocationCreateRequest;
import com.bounswe.group8.payload.dto.LocationDto;
import com.bounswe.group8.service.LocationService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequestMapping("/api/location")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LocationController {

    final LocationService locationService;

    /**
     * Creates a new address in the database under a given title.
     * 30 addresses per title limit.
     *
     * @param locationCreateRequest     create request
     * @return                          LocationDto - created location
     */
    @PostMapping
    public ResponseEntity<LocationDto> createLocation(
            @RequestBody LocationCreateRequest locationCreateRequest) {

        int count = locationService.countEntriesForTitle(locationCreateRequest.getTitle());
        if(count >= 30)
            return ResponseEntity.noContent().build();

        Long locationId = locationService.createLocation(locationCreateRequest).getId();

        if(locationId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(locationId)
                        .toUri()
        ).build();
    }

    /**
     *
     * @param title     String title
     * @return          Integer
     */
    @GetMapping("/{title}/count")
    public ResponseEntity<Integer> getCountByTitle(
            @PathVariable String title) {

        Integer count = locationService.countEntriesForTitle(title);

        return ResponseEntity.ok().body(count);
    }
}
