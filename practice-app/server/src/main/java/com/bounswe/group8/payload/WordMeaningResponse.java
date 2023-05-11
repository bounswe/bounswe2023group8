package com.bounswe.group8.payload;

import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WordMeaningResponse {

    String word;

    String phonetic;

    List<String> sourceUrls;

    List<Meanings> meanings;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Meanings {

        String partOfSpeech;

        List<Definitions> definitions;

        List<String> synonyms;

        List<String> antonyms;

    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Definitions {

        String definition;

    }

}
