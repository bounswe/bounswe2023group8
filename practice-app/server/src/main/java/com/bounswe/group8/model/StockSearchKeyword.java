package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "stock_search_keyword")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockSearchKeyword {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "keyword", nullable = false)
    String keyword;

    @Column(name = "stock_info_id", nullable = false)
    Long stockInfoId;

}
