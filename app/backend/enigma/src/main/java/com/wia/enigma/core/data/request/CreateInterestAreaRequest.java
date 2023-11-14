package com.wia.enigma.core.data.request;


import com.wia.enigma.dal.enums.EnigmaAccessLevel;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class CreateInterestAreaRequest {

    @NotNull
    EnigmaAccessLevel accessLevel;

    @NotNull
    String name;

    @NotNull
    List<Long> nestedInterestAreas;

    @NotNull
    List<String> wikiTags;
}
