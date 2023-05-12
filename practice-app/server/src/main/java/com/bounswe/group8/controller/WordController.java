package com.bounswe.group8.controller;

import com.bounswe.group8.payload.AddFavRequest;
import com.bounswe.group8.payload.WordMeaningResponse;
import com.bounswe.group8.payload.dto.FavouriteWordDto;
import com.bounswe.group8.payload.dto.WordMeaningDto;
import com.bounswe.group8.service.WordService;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.List;

@RestController
@RequestMapping("/api/word")
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class WordController {
    
    final WordService wordService;

    @GetMapping("/search/{word}")
    public ResponseEntity<?> getWordMeaning(
            @PathVariable String word) {
        
        WordMeaningDto wordMeaningDto = wordService.getWordMeaning(word);
        
        if (wordMeaningDto == null)
            return ResponseEntity.badRequest().body("Error while getting word meaning");

        return ResponseEntity.ok(wordMeaningDto);
    }

    @PostMapping("/favourite")
    public ResponseEntity<?> addFavouriteWord(
            @RequestBody AddFavRequest request) {

        Long favouriteWordId = wordService.addFavouriteWord(request);

        if (favouriteWordId == null)
            return ResponseEntity.badRequest().body("Error while adding favourite word");

        return ResponseEntity.ok(favouriteWordId);
    }

    @GetMapping("/favourite/all")
    public ResponseEntity<?> getAllFavouriteWords(
            @RequestParam(required = false) Long userId) {

        List<FavouriteWordDto> favoriteWords = wordService.getFavouriteWords(userId);

        if (favoriteWords == null)
            return ResponseEntity.badRequest().body("Error while getting favourite words");

        return ResponseEntity.ok(favoriteWords);
    }
}
