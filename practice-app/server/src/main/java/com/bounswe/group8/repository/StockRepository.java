package com.bounswe.group8.repository;

import com.bounswe.group8.model.Stock;
import org.springframework.data.jpa.repository.JpaRepository;

public interface StockRepository extends JpaRepository<Stock, Long> {

    Stock findFirstStockBySymbolOrderByTradingDayDesc(String symbol);

}
