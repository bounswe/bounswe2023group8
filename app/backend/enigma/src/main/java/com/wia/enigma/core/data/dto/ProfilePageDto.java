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

        Date birthday;

        List<EnigmaUserDto> followers;

        List<EnigmaUserDto> following;

        List<InterestAreaSimpleDto> interestAreas;

        List<Post> posts;
}
