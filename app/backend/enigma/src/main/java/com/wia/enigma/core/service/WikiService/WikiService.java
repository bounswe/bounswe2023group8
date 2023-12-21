package com.wia.enigma.core.service.WikiService;

import com.wia.enigma.dal.entity.WikiTag;

import java.util.List;
import java.util.Map;

public interface WikiService {

    List<Map<String, Object>> searchWikiTags(String searchKey);

    List<WikiTag> getWikiTags(List<String> ids);
}
