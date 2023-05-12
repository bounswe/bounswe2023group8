package com.bounswe.group8.payload.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Data
@Accessors(chain = true)
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class TranslateDto {

    String type = "translate";

    Long id;

    String text;

}
