package com.bounswe.group8.payload.dto;

import com.bounswe.group8.model.Stock;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Data
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
@JsonInclude(JsonInclude.Include.NON_NULL)
public class StockDto {

    Long id;

    String symbol;

    @JsonFormat(shape = JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd")
    Timestamp tradingDay;

    Double open;

    Double high;

    Double low;

    Double close;

    Double price;

    Long volume;

    public static StockDto convertToStockDto(Stock Stock) {
        return new StockDto(
                null,
                Stock.getSymbol(),
                Stock.getTradingDay(),
                Stock.getOpen(),
                Stock.getHigh(),
                Stock.getLow(),
                Stock.getClose(),
                Stock.getPrice(),
                Stock.getVolume()
        );
    }
}
