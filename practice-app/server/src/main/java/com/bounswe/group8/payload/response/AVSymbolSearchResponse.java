package com.bounswe.group8.payload.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.util.List;

@Data
@NoArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AVSymbolSearchResponse {

    List<BestMatch> bestMatches;

    @Data
    @NoArgsConstructor
    @FieldDefaults(level = AccessLevel.PRIVATE)
    public static class BestMatch {

        @JsonProperty("1. symbol")
        String symbol;

        @JsonProperty("2. name")
        String name;

        @JsonProperty("3. type")
        String type;

        @JsonProperty("4. region")
        String region;

        @JsonProperty("5. marketOpen")
        String marketOpen;

        @JsonProperty("6. marketClose")
        String marketClose;

        @JsonProperty("7. timezone")
        String timezone;

        @JsonProperty("8. currency")
        String currency;

        @JsonProperty("9. matchScore")
        String matchScore;

    }

}
