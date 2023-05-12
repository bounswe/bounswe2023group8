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
public class StockPriceResponse {

    String stock;

    List<String> sourceUrls;

    List<Prices> prices;

    Double h;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Prices {

        List<Long> prices;

    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Definitions {

        String definition;

    }

}