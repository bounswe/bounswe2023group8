package com.bounswe.group8.payload.dto;
import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Accessors(chain = true)
@NoArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)

public class FavouriteWordDto {
    String word;
    String meaning;
}
