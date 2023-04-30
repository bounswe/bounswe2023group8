package com.bounswe.group8.payload.dto;


import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class UserDto {

    String type = "user";

    Long id;

    String username;

    List<PostDto> posts;

}
