package com.bounswe.group8.controller;

import com.bounswe.group8.payload.dto.StockDto;
import com.bounswe.group8.service.StockService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/stock")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockController {

    final StockService stockService;

    @GetMapping("/all")
    public ResponseEntity<?> getEveryStockData() {

        List<StockDto> stockDtoList = stockService.findEveryStock();

        if (stockDtoList.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(stockDtoList);
    }

    @GetMapping("/{stockId}")
    public ResponseEntity<?> getStockById(@PathVariable String stockId,
                                          @RequestParam(defaultValue = "false") Boolean latest) {

        if (latest == null)
            latest = false;

        StockDto stockDto = latest ?
                stockService.findLatestStockBySymbol(stockId) : stockService.findStockBySymbol(stockId);

        if (stockDto == null)
            return ResponseEntity.notFound().build();

        return ResponseEntity.ok(stockDto);
    }

    @GetMapping("/search")
    public ResponseEntity<?> searchStock(@RequestParam String keyword) {

        List<StockDto> stockDtoList = stockService.searchStock(keyword);

        if (stockDtoList.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(stockDtoList);
    }


}
