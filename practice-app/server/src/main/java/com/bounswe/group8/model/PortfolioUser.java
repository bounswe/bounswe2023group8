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
@Table(name = "portfolio_user")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PortfolioUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "username", nullable = false)
    String username;

    @ManyToOne(fetch = FetchType.LAZY)
    Portfolio portfolio;

    @Column(name = "role", nullable = false)
    String role;

    @Column(name = "deleted", nullable = false)
    Boolean deleted;

}
