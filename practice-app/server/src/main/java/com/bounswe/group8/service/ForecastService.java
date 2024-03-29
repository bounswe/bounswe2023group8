package com.bounswe.group8.service;

import com.bounswe.group8.mapper.ForecastMapper;
import com.bounswe.group8.model.Forecast;
import com.bounswe.group8.payload.dto.ForecastDto;
import com.bounswe.group8.repository.ForecastRepository;
import com.bounswe.group8.payload.ForecastCreateRequest;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ForecastService {

    final ForecastRepository forecastRepository;

    /**
     * Create a new forecast in the database
     *
     * @param request   ForecastCreateRequest
     * @return          saved location
     */
    public Forecast createForecast(ForecastCreateRequest request) {

        Forecast forecast = Forecast.builder()
                .city(request.getCity())
                .country(request.getCountry())
                .high(request.getHigh())
                .low(request.getLow())
                .date(request.getDate())
                .build();

        return forecastRepository.save(forecast);

    }

    /**
     * Get all forecasts.
     *
     * @return List of all forecasts
     */
    public List<ForecastDto> getAll() {

        List<Forecast> forecasts = forecastRepository.findAll();

        return forecasts.stream()
                .map(ForecastMapper::forecastToForecastDto)
                .collect(Collectors.toList());

    }

}
