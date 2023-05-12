package com.bounswe.group8.repository;

import com.bounswe.group8.model.StockInfo;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Set;

public interface StockInfoRepository extends JpaRepository<StockInfo, Long> {

    Set<StockInfo> findAllBySymbolIsIn(Set<String> symbols);

}
