package com.wia.enigma.core.service.TagSuggestion;

import com.wia.enigma.core.data.dto.WikiTagSuggestionDto;
import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.EntityType;

import java.util.List;

public interface TagSuggestionService {

    List<WikiTagSuggestionDto> getSuggestedTags(Long entityId, EntityType entityType, Long userId);
    void suggestTags(List<String> tags, Long entityId, EntityType entityType, Long userId);

    void acceptTagSuggestion(Long tagSuggestionId, Long userId);

    void rejectTagSuggestion(Long tagSuggestionId, Long userId);
}
