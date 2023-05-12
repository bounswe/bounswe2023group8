package com.bounswe.group8.payload.request;

import lombok.Data;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class PostCreateRequest {

        String title;

        String content;

        Long userId;

}
