package com.wia.enigma.core.service.InterestAreaService;

import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.request.CreateInterestAreaRequest;
import com.wia.enigma.dal.enums.EnigmaAccessLevel;

import java.util.List;

public interface InterestAreaService {

    public InterestAreaDto getInterestArea(Long id);
    public InterestAreaSimpleDto createInterestArea(Long enigmaUserId, String name, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> entityTags);

    public InterestAreaSimpleDto updateInterestArea(Long id, String name, EnigmaAccessLevel accessLevel, List<Long> nestedInterestAreas, List<String> entityTags);
    public void deleteInterestArea(Long id);
}
