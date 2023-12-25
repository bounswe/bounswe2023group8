package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.WikiTagSuggestionDto;
import com.wia.enigma.core.data.request.TagSuggestionRequest;
import com.wia.enigma.core.service.TagSuggestion.TagSuggestionService;
import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.EntityType;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/tag-suggestion")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TagSuggestionController {

    final TagSuggestionService tagSuggestionService;

    @GetMapping()
    public ResponseEntity<?> getTagSuggestions(@Valid @NotNull @RequestParam(name = "entityId") Long entityId,
                                               @Valid @NotNull @RequestParam(name="entityType") EntityType entityType ,
                                               EnigmaAuthenticationToken token) {

        List<WikiTagSuggestionDto> wikiTagSuggestionDtos = tagSuggestionService.getSuggestedTags(entityId, entityType, token.getEnigmaUserId());
        return ResponseEntity.ok(wikiTagSuggestionDtos);
    }

    @PostMapping()
    public ResponseEntity<?> addTagSuggestions(@RequestBody TagSuggestionRequest tagSuggestionRequest,
                                              EnigmaAuthenticationToken token) {

        tagSuggestionService.suggestTags(tagSuggestionRequest.getTags(), tagSuggestionRequest.getEntityId(),
                tagSuggestionRequest.getEntityType(), token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    @GetMapping("/accept")
    public ResponseEntity<?> acceptTagSuggestion(@RequestParam Long tagSuggestionId,
                                                 EnigmaAuthenticationToken token) {

        tagSuggestionService.acceptTagSuggestion(tagSuggestionId, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }

    @GetMapping("/reject")
    public ResponseEntity<?> rejectTagSuggestion(@RequestParam Long tagSuggestionId,
                                                 EnigmaAuthenticationToken token) {

        tagSuggestionService.rejectTagSuggestion(tagSuggestionId, token.getEnigmaUserId());

        return ResponseEntity.ok().build();
    }
}
