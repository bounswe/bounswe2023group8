package com.bounswe.group8.service;

import com.bounswe.group8.model.Stock;
import com.bounswe.group8.repository.StockRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockService {

    final StockRepository stockRepository;

}
