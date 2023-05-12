package com.bounswe.group8.repository;

import com.bounswe.group8.model.Stock;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface StockRepository extends JpaRepository<Stock, Long> {

    Stock findFirstStockBySymbolOrderByTradingDayDesc(String symbol);

    Set<Stock> findAllBySymbolContainingIgnoreCase(String symbol);

}
