package com.bounswe.group8.repository;

import com.bounswe.group8.model.Forecast;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ForecastRepository extends JpaRepository<Forecast, Long> {

    Forecast findForecastByKey(String key);

}
