package com.wia.enigma.core.service.WikiService;

import com.wia.enigma.core.data.dto.WikiTagDto;
import com.wia.enigma.dal.entity.WikiTag;

import java.util.List;
import java.util.Map;

public interface WikiService {

    public List<Map<String, Object>> searchWikiTags(String searchKey);

    public List<WikiTag> getWikiTags(List<String> ids);
}
