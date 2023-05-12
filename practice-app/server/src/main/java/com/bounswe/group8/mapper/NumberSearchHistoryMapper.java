package com.bounswe.group8.mapper;

import com.bounswe.group8.model.NumberSearchHistory;
import com.bounswe.group8.payload.dto.NumberSearchHistoryDto;

public class NumberSearchHistoryMapper {

    public static NumberSearchHistoryDto nshToNshDto(NumberSearchHistory numberSearchHistory){
        return new NumberSearchHistoryDto()
                .setSearchedNumber(numberSearchHistory.getSearchedNumber())
                .setSearchCount(numberSearchHistory.getSearchCount());
    }
}
