package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.core.data.request.CreateInterestAreaRequest;
import com.wia.enigma.core.data.response.FollowRequestsResponse;
import com.wia.enigma.dal.entity.InterestArea;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;

import java.util.List;

public interface InterestAreaService {

    InterestAreaDto getInterestArea(Long id, Long enigmaUserId);
    InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String title, String description, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> entityTags);
    InterestAreaSimpleDto updateInterestArea(Long id, String name, String description, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> entityTags);
    void deleteInterestArea(Long id);
    void followInterestArea(Long enigmaUserId, Long interestAreaId);
    void unfollowInterestArea(Long enigmaUserId, Long interestAreaId);
    List<EnigmaUserDto> getFollowers(Long userId, Long followedId);
    List<InterestArea> getNestedInterestAreas(Long id, Long enigmaUserId);
    List<InterestAreaSimpleDto>  search(Long userId, String searchKey);
    Boolean checkInterestAreaExist(Long id);
    List<FollowRequestsResponse> getFollowRequests(Long userId, Long interestAreaId);
    void acceptFollowRequest(Long requestId, Long userId);
    void rejectFollowRequest(Long requestId, Long userId);
}
