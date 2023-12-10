package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.core.service.WikiService.WikiService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/wiki")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WikiController {

    final WikiService wikiService;

    /**
     * WA-7: Searches wiki tags.
     */
    @GetMapping("/search")
    public ResponseEntity<?>  searchWikiTags(@Valid @NotNull @RequestParam(name = "searchKey") String searchKey) {

        List<Map<String, Object>> search = wikiService.searchWikiTags(searchKey);

        return ResponseEntity.ok(search);
    }

}
