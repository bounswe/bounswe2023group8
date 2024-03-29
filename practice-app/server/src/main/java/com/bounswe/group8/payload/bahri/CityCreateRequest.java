package com.bounswe.group8.payload.bahri;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class CityCreateRequest {

    String name;
    String country;
    int population;
}
