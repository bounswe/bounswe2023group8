package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.SearchDto;
import com.wia.enigma.core.service.SearchService.SearchService;
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

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/search")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class SearchController {

    final SearchService searchService;
    @GetMapping("")
    public ResponseEntity<?> search(@Valid @NotNull @RequestParam(name = "searchKey") String searchKey,  EnigmaAuthenticationToken token) {

        SearchDto searchDto = searchService.search(token.getEnigmaUserId(), searchKey);
        return ResponseEntity.ok(searchDto);
    }
}
