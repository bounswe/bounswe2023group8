package com.wia.enigma.core.data.dto;

import com.wia.enigma.dal.enums.AudienceType;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class EnigmaAuthorities {

    /* TODO */

    Long enigmaUserId;

    AudienceType audienceType;

    public boolean canModerate(Long interestAreaId) {

        if (interestAreaId == null)
            return false;

        return true;
    }
}
