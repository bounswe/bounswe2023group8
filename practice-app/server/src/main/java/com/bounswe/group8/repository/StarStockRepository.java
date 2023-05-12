package com.bounswe.group8.repository;

import com.bounswe.group8.model.StarStock;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface StarStockRepository extends JpaRepository<StarStock, Long> {
    List<StarStock> findAllByUserId(Long userId);
}