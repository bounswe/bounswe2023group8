package com.bounswe.group8.service;

import com.bounswe.group8.mapper.NumberSearchHistoryMapper;
import com.bounswe.group8.model.NumberSearchHistory;
import com.bounswe.group8.payload.NumberSearchHistoryCreateRequest;
import com.bounswe.group8.payload.dto.NumberSearchHistoryDto;
import com.bounswe.group8.repository.NumberSearchHistoryRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NumberSearchHistoryService {

    final NumberSearchHistoryRepository numberSearchHistoryRepository;

    public NumberSearchHistoryDto updateSearchCount(
            NumberSearchHistoryCreateRequest numberSearchHistoryCreateRequest) {

        NumberSearchHistory oldObject = numberSearchHistoryRepository
                .findNumberSearchHistoryBySearchedNumber(numberSearchHistoryCreateRequest.getSearchedNumber());

        if(oldObject == null) {
            return NumberSearchHistoryMapper.nshToNshDto(
                    numberSearchHistoryRepository.save(new NumberSearchHistory()
                    .setSearchCount(1)
                    .setSearchedNumber(numberSearchHistoryCreateRequest.getSearchedNumber())));
        }

        numberSearchHistoryRepository.delete(oldObject);

        NumberSearchHistory newNumberSearchHistory = new NumberSearchHistory(oldObject.getSearchedNumber(),
                oldObject.getSearchCount() + 1);

        numberSearchHistoryRepository.save(newNumberSearchHistory);

        return NumberSearchHistoryMapper.nshToNshDto(newNumberSearchHistory);

    }

    public NumberSearchHistoryDto getMaxSearchedNumber() {
        return NumberSearchHistoryMapper.nshToNshDto(
                numberSearchHistoryRepository.findNumberSearchHistoryByMaxSearchCount());
    }

}
