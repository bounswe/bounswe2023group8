package com.bounswe.group8.mapper;

import com.bounswe.group8.model.Location;
import com.bounswe.group8.payload.dto.LocationDto;

public class LocationMapper {

    public static LocationDto locationToLocationDto(Location location){
        return new LocationDto()
                .setId(location.getId())
                .setLatitude(location.getLatitude())
                .setLongitude(location.getLongitude())
                .setAddress(location.getAddress())
                .setTitle(location.getTitle());
    }

}
