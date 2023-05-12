package com.bounswe.group8.service;

import com.bounswe.group8.model.PortfolioUser;
import com.bounswe.group8.repository.PortfolioUserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PortfolioUserService {

    final PortfolioUserRepository portfolioUserRepository;


}
