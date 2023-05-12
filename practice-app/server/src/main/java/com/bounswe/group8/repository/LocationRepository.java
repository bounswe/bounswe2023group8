package com.bounswe.group8.repository;

import com.bounswe.group8.model.Location;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LocationRepository extends JpaRepository<Location, Long>{

    List<Location> findLocationsByTitle(String title);

    int countByTitle(String title);
}
