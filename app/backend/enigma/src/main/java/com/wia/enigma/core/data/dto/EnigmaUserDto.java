package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.EnigmaUser;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;
import java.util.Date;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class EnigmaUserDto {

    Long id;

    String username;

    String name;

    String email;

    Date birthday;

    String pictureUrl;

    Timestamp createTime;
}
