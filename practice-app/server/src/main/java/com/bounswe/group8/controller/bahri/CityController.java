package com.bounswe.group8.controller.bahri;

import com.bounswe.group8.model.bahri.City;
import com.bounswe.group8.repository.bahri.CityRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/city")
public class CityController {

    private final CityRepository cityRepository;

    @Autowired
    public CityController(CityRepository cityRepository) {
        this.cityRepository = cityRepository;
    }

    @PostMapping
    public ResponseEntity<String> createCity(@RequestBody City city) {
        try {
            // Save the city object to the database
            cityRepository.save(city);
            return ResponseEntity.status(HttpStatus.CREATED).body("City created successfully!");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Failed to create city");
        }
    }

    @GetMapping
    public ResponseEntity<List<City>> getAllCities() {
        try {
            List<City> cities = cityRepository.findAll();
            return ResponseEntity.ok(cities);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}

