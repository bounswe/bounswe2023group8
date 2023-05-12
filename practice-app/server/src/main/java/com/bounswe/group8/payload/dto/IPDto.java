package com.bounswe.group8.payload.dto;

import lombok.AccessLevel;
import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = AccessLevel.PRIVATE)
public class IPDto {

    String type = "ip";

    Long id;
    String ip;
    String city;
    String country;
}