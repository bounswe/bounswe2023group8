package com.bounswe.group8.stock;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.when;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.sql.Timestamp;
import java.util.*;

import com.bounswe.group8.controller.StockController;
import com.bounswe.group8.payload.dto.StockAutocompleteInfoDto;
import com.bounswe.group8.payload.dto.StockDto;
import com.bounswe.group8.service.StockService;
import org.junit.jupiter.api.Test;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

public class StockControllerTest {

    @Test
    public void testGetEveryStockData() {
        // Create mock data for the stockDtoList
        List<StockDto> stockDtoList = new ArrayList<>();
        stockDtoList.add(new StockDto(1L, "AAPL", new Timestamp(1620806400000L), 100.0, 200.0, 50.0, 150.0, 175.0, 1000L));
        stockDtoList.add(new StockDto(2L, "GOOG", new Timestamp(1620806400000L), 200.0, 300.0, 150.0, 250.0, 275.0, 2000L));

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.findEveryStock()).thenReturn(stockDtoList);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<List<StockDto>> response = stockController.getEveryStockData();

        // Assert the response
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(stockDtoList, response.getBody());
    }

    @Test
    public void testGetEveryStockDataEmptyList() {
        // Create an empty stockDtoList
        List<StockDto> stockDtoList = new ArrayList<>();

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.findEveryStock()).thenReturn(stockDtoList);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<List<StockDto>> response = stockController.getEveryStockData();

        // Assert the response
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        assertNull(response.getBody());
    }

    @Test
    public void testGetStockByIdLatest() {
        // Create mock data for the stockDto
        StockDto stockDto = new StockDto(1L, "AAPL", new Timestamp(1620806400000L), 100.0, 200.0, 50.0, 150.0, 175.0, 1000L);

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.findLatestStockBySymbol("AAPL")).thenReturn(stockDto);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<StockDto> response = stockController.getStockById("AAPL", true);

        // Assert the response
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(stockDto, response.getBody());
    }

    @Test
    public void testGetStockByIdNotLatest() {
        // Create mock data for the stockDto
        StockDto stockDto = new StockDto(1L, "AAPL", new Timestamp(1620806400000L), 100.0, 200.0, 50.0, 150.0, 175.0, 1000L);

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.findStockBySymbol("AAPL")).thenReturn(stockDto);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<StockDto> response = stockController.getStockById("AAPL", false);

        // Assert the response
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(stockDto, response.getBody());
    }


    @Test
    public void testGetStockByIdNotFound() {
        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.findLatestStockBySymbol("AAPL")).thenReturn(null);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<StockDto> response = stockController.getStockById("AAPL", true);

        // Assert the response
        assertEquals(HttpStatus.NOT_FOUND, response.getStatusCode());
        assertNull(response.getBody());
    }

    @Test
    public void testSearchStock() {
        // Create mock data for the stockDtoSymbolMap
        Map<String, List<StockDto>> stockDtoSymbolMap = new HashMap<>();
        List<StockDto> stockDtoList = new ArrayList<>();
        stockDtoList.add(new StockDto(1L, "AAPL", new Timestamp(1620806400000L), 100.0, 200.0, 50.0, 150.0, 175.0, 1000L));
        stockDtoList.add(new StockDto(2L, "AAPL", new Timestamp(1620892800000L), 200.0, 300.0, 150.0, 250.0, 275.0, 2000L));
        stockDtoSymbolMap.put("AAPL", stockDtoList);

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.searchStockData("AAPL")).thenReturn(stockDtoSymbolMap);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<Map<String, List<StockDto>>> response = stockController.searchStock("AAPL");

        // Assert the response
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(stockDtoSymbolMap, response.getBody());
    }

    @Test
    public void testSearchStockNoContent() {
        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.searchStockData("AAPL")).thenReturn(new HashMap<>());

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<Map<String, List<StockDto>>> response = stockController.searchStock("AAPL");

        // Assert the response
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        assertNull(response.getBody());
    }

    @Test
    public void testAutocompleteStockInfo() {
        // Create mock data for the stockAutocompleteInfoDtoList
        List<StockAutocompleteInfoDto> stockAutocompleteInfoDtoList = new ArrayList<>();
        stockAutocompleteInfoDtoList.add(new StockAutocompleteInfoDto("AAPL", "Apple Inc."));

        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.autoComplete("AAPL")).thenReturn(stockAutocompleteInfoDtoList);

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<List<StockAutocompleteInfoDto>> response = stockController.autocompleteStockInfo("AAPL");

        // Assert the response
        assertEquals(HttpStatus.OK, response.getStatusCode());
        assertEquals(stockAutocompleteInfoDtoList, response.getBody());
    }

    @Test
    public void testAutocompleteStockInfoNoContent() {
        // Mock the stockService
        StockService stockServiceMock = mock(StockService.class);
        when(stockServiceMock.autoComplete("AAPL")).thenReturn(new ArrayList<>());

        // Create an instance of the controller and set the mocked stockService
        StockController stockController = new StockController(stockServiceMock);

        // Call the endpoint
        ResponseEntity<List<StockAutocompleteInfoDto>> response = stockController.autocompleteStockInfo("AAPL");

        // Assert the response
        assertEquals(HttpStatus.NO_CONTENT, response.getStatusCode());
        assertNull(response.getBody());
    }
}