package com.bounswe.group8.payload.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class LocationDto {

    String type = "location";

    Long id;

    double latitude;

    double longitude;

    String address;

    String title;
}
