package com.bounswe.group8.repository;

import com.bounswe.group8.model.NumberSearchHistory;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

public interface NumberSearchHistoryRepository extends JpaRepository<NumberSearchHistory, Long> {

    @Query(
            value = "SELECT * FROM numbers WHERE SEARCH_COUNT = (" +
                    "SELECT MAX(SEARCH_COUNT) FROM numbers)",
            nativeQuery = true)
    NumberSearchHistory findNumberSearchHistoryByMaxSearchCount();

    NumberSearchHistory findNumberSearchHistoryBySearchedNumber(Long searchedNumber);

}
