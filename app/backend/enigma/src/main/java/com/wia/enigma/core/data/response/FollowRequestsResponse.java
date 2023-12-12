package com.wia.enigma.core.data.response;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.FieldDefaults;

@Data
@Builder
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class FollowRequestsResponse {

    Long requestId;

    EnigmaUserDto follower;
}
