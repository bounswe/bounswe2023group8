package com.bounswe.group8.mapper.bahri;

import com.bounswe.group8.model.bahri.City;
import com.bounswe.group8.payload.dto.bahri.CityDto;

public class CityMapper {
    public static CityDto cityToCityDto(City city) {
        return new CityDto()
                .setId(city.getId())
                .setName(city.getName())
                .setCountry(city.getCountry())
                .setPopulation(city.getPopulation());
    }
}

