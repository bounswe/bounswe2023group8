package com.bounswe.group8.payload;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class LocationCreateRequest {

    double latitude;

    double longitude;

    String address;

    String title;

}
