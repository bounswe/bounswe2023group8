package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.EnigmaUser;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.util.Date;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class EnigmaUserDto {

    Long id;

    String username;

    String name;

    String email;

    Date birthday;

    Timestamp createdTime;
}
