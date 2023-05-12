package com.bounswe.group8.repository.bahri;

import com.bounswe.group8.model.bahri.City;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CityRepository extends JpaRepository<City, Long> {

    City findByName(String name);
}
