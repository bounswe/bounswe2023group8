package com.wia.enigma.core.data.dto;

import lombok.*;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Builder
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class SearchDto {

        List<InterestAreaSimpleDto> interestAreas;
        List<EnigmaUserDto> users;

}
