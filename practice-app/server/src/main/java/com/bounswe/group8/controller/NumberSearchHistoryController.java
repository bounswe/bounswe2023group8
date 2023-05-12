package com.bounswe.group8.controller;

import com.bounswe.group8.payload.NumberSearchHistoryCreateRequest;
import com.bounswe.group8.payload.dto.NumberSearchHistoryDto;
import com.bounswe.group8.service.NumberSearchHistoryService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequestMapping("/api/numbers")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NumberSearchHistoryController {


    final NumberSearchHistoryService numberSearchHistoryService;

    @PostMapping()
    public ResponseEntity<NumberSearchHistoryDto> addNumberSearch(
            @RequestBody NumberSearchHistoryCreateRequest numberSearchHistoryCreateRequest
            ) {

        Long id = numberSearchHistoryService.updateSearchCount(numberSearchHistoryCreateRequest).getSearchedNumber();

        if(id == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(id)
                        .toUri()
        ).build();

    }

    @GetMapping("/max")
    public ResponseEntity<NumberSearchHistoryDto> getMaxSearchedNumber() {
        return ResponseEntity.ok().body(numberSearchHistoryService.getMaxSearchedNumber());
    }

//    @GetMapping

}
