package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.entity.Post;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.Date;
import java.util.List;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class ProfilePageDto {

        Long id;

        String username;

        String name;

        Date birthday;

        Long followers;

        Long following;

        String profilePictureUrl;
}
