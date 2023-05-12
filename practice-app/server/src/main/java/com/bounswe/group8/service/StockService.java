package com.bounswe.group8.service;

import com.bounswe.group8.exception.custom.ApiRequestException;
import com.bounswe.group8.exception.custom.ResourceNotFoundException;
import com.bounswe.group8.model.Stock;
import com.bounswe.group8.model.StockInfo;
import com.bounswe.group8.model.StockSearchKeyword;
import com.bounswe.group8.payload.dto.StockAutocompleteInfoDto;
import com.bounswe.group8.payload.dto.StockDto;
import com.bounswe.group8.payload.response.AVGlobalQuoteResponse;
import com.bounswe.group8.payload.response.AVSymbolSearchResponse;
import com.bounswe.group8.projections.StockAutocompleteProjection;
import com.bounswe.group8.repository.StockInfoRepository;
import com.bounswe.group8.repository.StockRepository;
import com.bounswe.group8.repository.StockSearchKeywordRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;
import org.springframework.beans.factory.annotation.Value;


import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockService {

    final StockRepository stockRepository;

    final StockInfoRepository stockInfoRepository;

    final StockSearchKeywordRepository stockSearchKeywordRepository;

    @Value("${api.alpha-vantage.base-url}")
    String baseUrl;

    @Value("${api.alpha-vantage.api-key}")
    String apiKey;

    /**
     * Fetches the latest stock data from Alpha Vantage API.
     * Checks the database for the latest stock data for the given symbol.
     * If the latest stock data is not before today, returns the latest stock data from database.
     * If the latest stock data is before today, fetches the latest stock data from Alpha Vantage API,
     * saves it to database and returns it.
     *
     * @param symbol Stock symbol
     * @return       StockDto
     */
    public StockDto findLatestStockBySymbol(String symbol) {

        /* Get stock data from database */

        Stock stock = stockRepository.findFirstStockBySymbolOrderByTradingDayDesc(symbol);

        if (stock != null)
            if (!isBeforeToday(stock.getTradingDay()))
                return StockDto.convertToStockDto(stock);

        /*  Get updated stock data */

        Stock updatedStock = getUpdatedStockData(symbol);

        /* Save updated stock data to database */

        stockRepository.save(updatedStock);

        return StockDto.convertToStockDto(updatedStock);
    }

    /**
     * Fetches any stock data for a given symbol, regardless of the date.
     *
     * @param symbol Stock symbol
     * @return       StockDto
     */
    public StockDto findStockBySymbol(String symbol) {

        Stock stock = stockRepository.findFirstStockBySymbolOrderByTradingDayDesc(symbol);

        if (stock != null)
            return StockDto.convertToStockDto(stock);

        /*  Get updated stock data if not found in database */

        Stock updatedStock = getUpdatedStockData(symbol);

        /* Save updated stock data to database */

        stockRepository.save(updatedStock);

        return StockDto.convertToStockDto(updatedStock);
    }

    /**
     * Finds all the stock data for symbols containing the keyword parameter.
     *
     * @param keyword   Stock symbol
     * @return          Map of (Symbol, List of StockDto)
     */
    public Map<String, List<StockDto>> searchStockData(String keyword) {

        Set<Stock> stockList = stockRepository.findAllBySymbolContainingIgnoreCase(keyword);

        if (stockList == null || stockList.isEmpty())
            return Map.of();

        return stockList.stream()
                .map(stock -> {
                        StockDto stockDto = StockDto.convertToStockDto(stock);
                        stockDto.setId(stock.getId());
                        return stockDto;
                })
                .collect(Collectors.groupingBy(StockDto::getSymbol));
    }

    /**
     * Fetches all stock data from database.
     *
     * @return       List of StockDto
     */
    public List<StockDto> findEveryStock() {

            List<Stock> stockList = stockRepository.findAll();

            if (stockList.isEmpty())
                return null;

            return stockList.stream()
                    .map(stock -> {
                            StockDto stockDto = StockDto.convertToStockDto(stock);
                            stockDto.setId(stock.getId());
                            return stockDto;
                    })
                    .collect(Collectors.toList());
    }

    /**
     * Auto-completes the keyword parameter with stock symbols.
     *
     * @param keyword  Stock symbol
     * @return         StockInfoDto
     */
    public List<StockAutocompleteInfoDto> autoComplete(String keyword) {

        List<StockAutocompleteInfoDto> stockInfoList = getStockAutocompleteInfoFromDatabase(keyword);

        if (!stockInfoList.isEmpty())
            return stockInfoList;

        Set<StockInfo> stockInfoListFromApi = getStockAutocompleteInfo(keyword);

        Set<StockInfo> stockInfoSet = stockInfoRepository.findAllBySymbolIsIn(
                stockInfoListFromApi.stream()
                        .map(StockInfo::getSymbol)
                        .collect(Collectors.toSet()));

        stockInfoListFromApi.removeAll(stockInfoSet);
        List<StockInfo> savedStockInfoList = stockInfoRepository.saveAll(stockInfoListFromApi);

        stockSearchKeywordRepository.saveAll(
                savedStockInfoList.stream()
                        .map(stockInfo -> new StockSearchKeyword(
                                null,
                                keyword,
                                stockInfo.getId()))
                        .collect(Collectors.toList())
        );

        return stockInfoListFromApi.stream()
                .map(stock -> new StockAutocompleteInfoDto(
                        stock.getSymbol(),
                        stock.getName()))
                .collect(Collectors.toList());
    }

    private Set<StockInfo> getStockAutocompleteInfo(String keyword) {

        log.info("Getting autocomplete data for keyword: {} from Alpha Vantage API", keyword);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("function", "SYMBOL_SEARCH")
                .queryParam("keywords", keyword)
                .queryParam("apikey", apiKey);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<AVSymbolSearchResponse> response = restTemplate
                .exchange(uriBuilder.toUriString(), HttpMethod.GET, null, AVSymbolSearchResponse.class);

        if (response.getStatusCode().isError()) {
            log.error("Could not get autocomplete data for keyword: {}", keyword);
            throw new ApiRequestException("Could not get autocomplete data for keyword: " +
                    keyword, response.getStatusCode().value());
        }

        if (response.getBody() == null) {
            log.error("Autocomplete data is null for keyword: {}", keyword);
            throw new ApiRequestException("Autocomplete data is null for keyword: " + keyword, 404);
        }

        List<AVSymbolSearchResponse.BestMatch> bestMatches = response.getBody().getBestMatches();
        return bestMatches.stream()
                .map(match -> new StockInfo(
                        null,
                        match.getSymbol(),
                        match.getName(),
                        match.getType(),
                        match.getRegion(),
                        match.getCurrency()
                    )
                ).collect(Collectors.toSet());
    }

    private List<StockAutocompleteInfoDto> getStockAutocompleteInfoFromDatabase(String keyword) {

        log.info("Getting autocomplete data for keyword: {} from database", keyword);

        List<StockAutocompleteProjection> stockInfoList =
                stockSearchKeywordRepository.findStockInfoBySearchKeyword(keyword);

        return stockInfoList.stream()
                .map(stockInfo -> new StockAutocompleteInfoDto(
                        stockInfo.getSymbol(),
                        stockInfo.getName()
                    )
                ).collect(Collectors.toList());
    }

    /**
     * Fetches the latest stock data from Alpha Vantage API and saves it to the database.
     *
     * @param symbol Stock symbol
     * @return       saved Stock object
     */
    private Stock getUpdatedStockData(String symbol) {

        log.info("Getting stock data for symbol: {} from Alpha Vantage API", symbol);

        UriComponentsBuilder uriBuilder = UriComponentsBuilder.fromHttpUrl(baseUrl)
                .queryParam("function", "GLOBAL_QUOTE")
                .queryParam("symbol", symbol)
                .queryParam("apikey", apiKey);

        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<AVGlobalQuoteResponse> response = restTemplate
                .exchange(uriBuilder.toUriString(), HttpMethod.GET, null, AVGlobalQuoteResponse.class);

        if (response.getStatusCode().isError()) {
            log.error("Could not get stock data for symbol: {}", symbol);
            throw new ApiRequestException("Could not get stock data for symbol: " + symbol, response.getStatusCode().value());
        }

        if (response.getBody() == null) {
            log.error("Stock data is null for symbol: {}", symbol);
            throw new ApiRequestException("Could not get stock data for symbol: " + symbol, response.getStatusCode().value());
        }

        AVGlobalQuoteResponse.GlobalQuote avGlobalQuoteResponse = response.getBody().getGlobalQuote();
        return new Stock(
                null,
                avGlobalQuoteResponse.getSymbol(),
                parseLatestTradingDay(avGlobalQuoteResponse.getLatestTradingDay()),
                Double.parseDouble(avGlobalQuoteResponse.getOpen()),
                Double.parseDouble(avGlobalQuoteResponse.getHigh()),
                Double.parseDouble(avGlobalQuoteResponse.getLow()),
                Double.parseDouble(avGlobalQuoteResponse.getPreviousClose()),
                Double.parseDouble(avGlobalQuoteResponse.getPrice()),
                Long.parseLong(avGlobalQuoteResponse.getVolume())
        );
    }

    private Timestamp parseLatestTradingDay(String latestTradingDay) {
        return Timestamp.valueOf(latestTradingDay + " 00:00:00");
    }

    private Boolean isBeforeToday(Timestamp date) {
        return date.toLocalDateTime().toLocalDate().isBefore(LocalDate.now());
    }

}
