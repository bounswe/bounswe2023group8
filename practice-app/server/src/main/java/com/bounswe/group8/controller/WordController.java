package com.bounswe.group8.controller;

import com.bounswe.group8.payload.WordMeaningResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
@RequestMapping("/api/word")
public class WordController {

    @GetMapping("/{word}")
    public ResponseEntity<WordMeaningResponse[]> getWordMeaning(@PathVariable String word) {

        // call external API to get the meaning of the given word
        String url = "https://api.dictionaryapi.dev/api/v2/entries/en/" + word;
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<WordMeaningResponse[]> responseEntity = restTemplate.getForEntity(url, WordMeaningResponse[].class);

        // check if the response is successful
        if (responseEntity.getStatusCode() == HttpStatus.OK) {
            WordMeaningResponse[] wordResponses = responseEntity.getBody();
            return ResponseEntity.ok(wordResponses);
        } else {
            // return a custom error response
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body(null);
        }
    }
}

