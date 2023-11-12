package com.wia.enigma.core.service;

import java.util.List;
import java.util.Map;

public interface WikiService {

    public List<Map<String, Object>> searchWikiTags(String searchKey);
}
