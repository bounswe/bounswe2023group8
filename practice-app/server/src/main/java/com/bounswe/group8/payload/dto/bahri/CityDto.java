package com.bounswe.group8.payload.dto.bahri;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CityDto {

    String type = "city";

    Long id;
    String name;
    String country;
    int population;
}

