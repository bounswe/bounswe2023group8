package com.bounswe.group8.controller;

import com.bounswe.group8.payload.AddStarRequest;
import com.bounswe.group8.payload.dto.StarStockDto;
import com.bounswe.group8.payload.dto.StockPriceDto;
import com.bounswe.group8.service.StarStockService;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/star-stock")
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
@RequiredArgsConstructor
public class StarStockController {

    final StarStockService stockService;

    @GetMapping("/search/{stock}")
    public ResponseEntity<?> getStockPrice(
            @PathVariable String stock) {

        StockPriceDto stockPriceDto = stockService.getStockPrice(stock);

        if (stockPriceDto == null)
            return ResponseEntity.badRequest().body("Error while getting stock price!");

        return ResponseEntity.ok(stockPriceDto);
    }

    @PostMapping("/star")
    public ResponseEntity<?> addStarStock(
            @RequestBody AddStarRequest request) {

        Long starStockId = stockService.addStarStock(request);

        if (starStockId == null)
            return ResponseEntity.badRequest().body("Error while adding star stock");

        return ResponseEntity.ok(starStockId);
    }

    @GetMapping("/star/all")
    public ResponseEntity<?> getAllStarStocks(
            @RequestParam(required = false) Long userId) {

        List<StarStockDto> starStocks = stockService.getStarStocks(userId);

        if (starStocks == null)
            return ResponseEntity.badRequest().body("Error while getting star stocks");

        return ResponseEntity.ok(starStocks);
    }
}