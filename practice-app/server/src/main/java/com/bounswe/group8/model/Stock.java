package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.AccessLevel;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Data
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "stock")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class Stock {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "symbol", nullable = false)
    String symbol;

    @Column(name = "trading_day", nullable = false)
    Timestamp tradingDay;

    @Column(name = "open", nullable = false)
    Double open;

    @Column(name = "high", nullable = false)
    Double high;

    @Column(name = "low", nullable = false)
    Double low;

    @Column(name = "close", nullable = false)
    Double close;

    @Column(name = "price", nullable = false)
    Double price;

    @Column(name = "volume", nullable = false)
    Long volume;

}
