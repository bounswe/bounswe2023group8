package com.wia.enigma.core.service.SearchService;

import com.wia.enigma.core.data.dto.SearchDto;

public interface SearchService {

    SearchDto search(Long userId, String searchKey);
}
