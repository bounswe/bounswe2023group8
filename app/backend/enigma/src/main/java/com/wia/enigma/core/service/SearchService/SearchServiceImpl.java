package com.wia.enigma.core.service.SearchService;

import com.wia.enigma.core.data.dto.SearchDto;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SearchServiceImpl implements SearchService {

    final EnigmaUserService enigmaUserService;
    final InterestAreaService interestAreaService;

    @Override
    public SearchDto search(Long userId, String searchKey){

            enigmaUserService.search(userId, searchKey);
            interestAreaService.search(userId, searchKey);

            SearchDto searchDto = SearchDto.builder()
                    .users(enigmaUserService.search(userId, searchKey))
                    .interestAreas(interestAreaService.search(userId, searchKey))
                    .build();

            return searchDto;
    }
}
