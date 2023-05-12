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
@Table(name = "stock_info")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class StockInfo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "symbol", nullable = false, unique = true)
    String symbol;

    @Column(name = "name", nullable = false)
    String name;

    @Column(name = "type", nullable = false)
    String type;

    @Column(name = "region", nullable = false)
    String region;

    @Column(name = "currency", nullable = false)
    String currency;

}
