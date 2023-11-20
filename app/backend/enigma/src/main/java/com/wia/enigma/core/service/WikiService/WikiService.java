package com.wia.enigma.core.service.WikiService;

import com.wia.enigma.core.data.dto.WikiTagDto;

import java.util.List;
import java.util.Map;

public interface WikiService {

    public List<Map<String, Object>> searchWikiTags(String searchKey);

    public List<WikiTagDto> getWikiTags(List<String> ids);
}
