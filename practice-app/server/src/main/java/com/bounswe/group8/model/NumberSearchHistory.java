package com.bounswe.group8.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.*;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

@Entity
@Table(name = "numbers")
@Data
@Builder
@Accessors(chain = true)
@NoArgsConstructor
@AllArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class NumberSearchHistory {

    @Id
    @Column(name = "searchedNumber", nullable = false, updatable = false, unique = true)
    Long searchedNumber;

    @Column(name = "searchCount", nullable = false)
    int searchCount;

}
