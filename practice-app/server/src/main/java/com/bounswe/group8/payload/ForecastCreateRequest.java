package com.bounswe.group8.payload;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.util.Date;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ForecastCreateRequest {

    String city;

    String country;

    String high;

    String low;

    Date date;

}
