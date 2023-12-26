package com.wia.enigma.core.data.request;

import com.wia.enigma.dal.enums.EntityType;
import jakarta.validation.constraints.NotEmpty;
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
public class TagSuggestionRequest {

    @NotNull
    Long entityId;

    @NotNull
    EntityType entityType;

    @NotEmpty
    List<String> tags;

}