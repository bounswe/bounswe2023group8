package com.bounswe.group8.payload.dto;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ForecastDto {

    String type = "forecast";

    Long id;

    String city;

    String country;

    String key;

}
