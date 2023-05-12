package com.bounswe.group8.controller;

import com.bounswe.group8.model.Stock;
import com.bounswe.group8.payload.dto.StockAutocompleteInfoDto;
import com.bounswe.group8.payload.dto.StockDto;
import com.bounswe.group8.service.StockService;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/stock")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockController {

    final StockService stockService;

    /**
     * S1: Get all stock data in the database.
     *
     * @return List of StockDto
     */
    @GetMapping("/all")
    public ResponseEntity<List<StockDto>> getEveryStockData() {

        List<StockDto> stockDtoList = stockService.findEveryStock();

        if (stockDtoList.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(stockDtoList);
    }

    /**
     * S2: Get stock data by stock symbol.
     * First searches the database, if not found, then searches the API.
     *
     * @param stockId Stock symbol
     * @param latest If true, returns the latest stock data from the database.
     * @return StockDto
     */
    @PostMapping("/{stockId}")
    public ResponseEntity<StockDto> getStockById(@PathVariable String stockId,
                                          @RequestParam(defaultValue = "false") Boolean latest) {

        if (latest == null)
            latest = false;

        StockDto stockDto = latest ?
                stockService.findLatestStockBySymbol(stockId) : stockService.findStockBySymbol(stockId);

        if (stockDto == null)
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(stockDto);
    }

    /**
     * S3: Search stock data from the database by keyword. Groups the results by stock symbol.
     * A stock symbol can have multiple results, with different dates.
     *
     * @param keyword Search keyword
     * @return Map of stock symbol and list of StockDto
     */
    @GetMapping("/search")
    public ResponseEntity<Map<String, List<StockDto>>> searchStock(@RequestParam @NotNull String keyword) {

        Map<String, List<StockDto>> stockDtoSymbolMap = stockService.searchStockData(keyword);

        if (stockDtoSymbolMap.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(stockDtoSymbolMap);
    }

    /**
     * S4: Auto complete stock symbol and company name by keyword.
     * Searches the database first, if not found, then searches the API.
     *
     * @param keyword Search keyword
     * @return List of StockAutocompleteInfoDto
     */
    @GetMapping("/autocomplete")
    public ResponseEntity<List<StockAutocompleteInfoDto>> autocompleteStockInfo(@RequestParam @NotNull String keyword) {

        List<StockAutocompleteInfoDto> stockAutocompleteInfoDtoList = stockService.autoComplete(keyword);
        if (stockAutocompleteInfoDtoList.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(stockAutocompleteInfoDtoList);
    }

}
