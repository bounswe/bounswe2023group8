package com.bounswe.group8.payload;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class WordMeaningResponse {
    private String word;
    private String phonetic;
    private String origin;
    private String definition;
    private String example;
}
