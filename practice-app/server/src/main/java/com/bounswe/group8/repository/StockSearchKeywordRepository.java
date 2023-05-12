package com.bounswe.group8.repository;

import com.bounswe.group8.model.StockSearchKeyword;
import com.bounswe.group8.projections.StockAutocompleteProjection;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface StockSearchKeywordRepository extends JpaRepository<StockSearchKeyword, Long> {

    @Query(value = "SELECT si.symbol, si.name " +
            "FROM stock_search_keyword AS ssk " +
            "JOIN stock_info AS si ON ssk.stock_info_id = si.id " +
            "WHERE ssk.keyword LIKE ?1 " +
            "LIMIT 10", nativeQuery = true)
    List<StockAutocompleteProjection> findStockInfoBySearchKeyword(String keyword);

}
