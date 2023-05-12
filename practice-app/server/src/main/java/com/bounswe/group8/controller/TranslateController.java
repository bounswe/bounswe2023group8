package com.bounswe.group8.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import com.bounswe.group8.payload.dto.TranslateDto;
import com.bounswe.group8.service.TranslateService;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

// ...

@RestController
@RequestMapping("/api/translate")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TranslateController {

    private final TranslateService translateService;
    private static final Logger logger = LoggerFactory.getLogger(UserController.class);


    @GetMapping("/all")
    public ResponseEntity<List<TranslateDto>> getAll(
    ) {
        logger.info("This is an informational message1");
        return ResponseEntity.ok(
                translateService.getAll()
        );
        // String translatedText = translateService.translateText(sourceLang, targetLang, text);
        // return "Translated Text: " + translatedText;
    }

    @PostMapping("")
    public ResponseEntity<String> handleData(@RequestBody String data) {
        // Process the received data
        Long translateId = translateService.createTranslate(data);

        if (translateId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(translateId)
                        .toUri())
                .build();

        // Perform operations with the data
        // ...
    }

}
