package com.wia.enigma.core.service.PageService;


import com.wia.enigma.core.data.dto.ProfilePageDto;

public interface PageService {

    ProfilePageDto getProfilePage(Long userId, Long profileId);

}
