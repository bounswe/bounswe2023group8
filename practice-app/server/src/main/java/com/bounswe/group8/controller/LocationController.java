package com.bounswe.group8.controller;

import com.bounswe.group8.payload.LocationCreateRequest;
import com.bounswe.group8.payload.dto.LocationDto;
import com.bounswe.group8.service.LocationService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.Schema;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

@RestController
@RequestMapping("/api/location")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LocationController {

    final LocationService locationService;

    /**
     * Creates a new location in the database under a given title.
     * 10 addresses per title limit.
     *
     * @param locationCreateRequest     Create request
     * @return                          Created location
     */
    @PostMapping
    @Operation(
            summary = "Post a new location.",
            description = "Create a new location in the database. There is a 10 location per title limit.",
            responses = {
                    @ApiResponse(description = "Added location")
            })
    public ResponseEntity<LocationDto> createLocation(
            @RequestBody LocationCreateRequest locationCreateRequest) {

        int count = locationService.countEntriesForTitle(locationCreateRequest.getTitle());
        if(count >= 10)
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
     * @param title Title under which locations are saved
     * @return      List of locations
     */
    @GetMapping("/{title}")
    @Operation(
            summary = "Get locations.",
            description = "Get locations saved under a title.",
            responses = {
                    @ApiResponse(description = "List of locations")
            })
    public ResponseEntity<List<LocationDto>> getLocationsByTitle(
            @PathVariable String title
    ) {
        return ResponseEntity.ok().body(locationService.getLocationsByTitle(title));
    }

    /**
     *
     * @param title     Title under which locations are saved
     * @return          Number of locations
     */
    @GetMapping("/{title}/count")
    @Operation(
            summary = "Get count of locations",
            description = "Get the count of locations saved under a title.",
            responses = {
                    @ApiResponse(description = "Count")
            })
    public ResponseEntity<Integer> getCountByTitle(
            @PathVariable String title) {

        return ResponseEntity.ok().body(locationService.countEntriesForTitle(title));
    }

}
