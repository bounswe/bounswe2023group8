package com.bounswe.group8.controller;

import com.bounswe.group8.payload.ForecastCreateRequest;
import com.bounswe.group8.payload.dto.ForecastDto;
import com.bounswe.group8.service.ForecastService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

@RestController
@RequestMapping("/api/forecast")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ForecastController {

    final ForecastService forecastService;

    /**
     * Creates a new address in the database under a given title.
     * 30 addresses per title limit.
     *
     * @param forecastCreateRequest     create request
     * @return                          ForecastDto - created forecast
     */
    @PostMapping
    public ResponseEntity<ForecastDto> createForecast(
            @RequestBody ForecastCreateRequest forecastCreateRequest) {

        Long forecastId = forecastService.createForecast(forecastCreateRequest).getId();

        if(forecastId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(forecastId)
                        .toUri()
        ).build();

    }

    /**
     * Delete a forecast.
     *
     * @param key   key of the forecast to be deleted.
     * @return      ForecastDto - deleted forecast
     */
    @DeleteMapping("/{key}")
    public ResponseEntity<ForecastDto> deleteForecast(@PathVariable String key) {

        ForecastDto forecastDto = forecastService.deleteForecastByKey(key);

        if (forecastDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(forecastDto);

    }

    /**
     * Get all forecasts.
     *
     * @return      List<ForecastDto> - list of forecasts
     */
    @GetMapping("/all")
    public ResponseEntity<List<ForecastDto>> getAllForecasts() {

        return ResponseEntity.ok(
                forecastService.getAll()
        );

    }

}
