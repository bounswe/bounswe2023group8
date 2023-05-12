package com.bounswe.group8.mapper;

import com.bounswe.group8.model.Forecast;
import com.bounswe.group8.payload.dto.ForecastDto;

public class ForecastMapper {

    public static ForecastDto forecastToForecastDto(Forecast forecast){
        return new ForecastDto()
                .setId(forecast.getId())
                .setCity(forecast.getCity())
                .setCountry(forecast.getCountry())
                .setHigh(forecast.getHigh())
                .setLow(forecast.getLow())
                .setDate(forecast.getDate());
    }

}
