package com.bounswe.group8.payload.dto;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@Accessors(chain = true)
@NoArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class WordMeaningDto {

    Integer status;

    List<Word> words;

    @Data
    @NoArgsConstructor
    @Accessors(chain = true)
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    @JsonInclude(JsonInclude.Include.NON_NULL)
    public static class Word {

        String word;

        String phonetic;

        PartOfSpeech noun;

        PartOfSpeech verb;

    }

    @Data
    @NoArgsConstructor
    @Accessors(chain = true)
    @FieldDefaults(level = lombok.AccessLevel.PRIVATE)
    public static class PartOfSpeech {

            List<String> definitions;

            List<String> synonyms;

            List<String> antonyms;

    }

}


