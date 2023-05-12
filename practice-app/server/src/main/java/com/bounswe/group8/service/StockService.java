package com.bounswe.group8.service;

import com.bounswe.group8.model.StarStock;
import com.bounswe.group8.model.User;
import com.bounswe.group8.payload.AddStarRequest;
import com.bounswe.group8.payload.StockPriceResponse;
import com.bounswe.group8.payload.dto.StarStockDto;
import com.bounswe.group8.payload.dto.StockPriceDto;
import com.bounswe.group8.repository.StarStockRepository;
import com.bounswe.group8.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockService {

    final StarStockRepository starStockRepository;

    final UserRepository userRepository;

    private String polygonApiKey = "zU5yH0bOuEGYnRBpqCxeRiuAAljoU_Rr";
    final String baseUrl = "https://api.polygon.io/v2/aggs/ticker/";


    public StockPriceDto getStockPrice(String stock) {

        String url = baseUrl + stock + "/range/1/day/2023-01-09/2023-01-09?apiKey=" + polygonApiKey;
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<StockPriceResponse[]> responseEntity;
        try {
            responseEntity = restTemplate.getForEntity(url, StockPriceResponse[].class);
        } catch (Exception e) {
            log.error("Error while getting stock price", e);
            return null;
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful())
            return null;

        StockPriceResponse[] stockResponses = responseEntity.getBody();
        assert stockResponses != null;
        return new StockPriceDto()
                .setStatus(responseEntity.getStatusCode().value())
                .setStocks(
                        Arrays.stream(stockResponses)
                                .map(stockResponse -> new StockPriceDto.Stock()
                                        .setStock(stockResponse.getStock())
                                        .setH(stockResponse.getH())
                                )
                                .collect(Collectors.toList())
                );
    }

    public List<StarStockDto> getStarStocks(Long userId){
        List<StarStock> starStocks = starStockRepository.findAllByUserId(userId);

        return starStocks.stream()
                .map(starStock -> new StarStockDto()
                        .setStock(starStock.getStock())
                        .setPrice(starStock.getPrice())
                ).collect(Collectors.toList());

    }

    public Long addStarStock(AddStarRequest request){
        User user = userRepository.findUserById(request.getUserId());

        if(user == null)
            throw new RuntimeException("User not found");

        StarStock starStock = new StarStock()
                .setUser(user)
                .setStock(request.getStock())
                .setPrice(request.getPrice());
        StarStock saved = starStockRepository.save(starStock);
        return saved.getId();
    }

}