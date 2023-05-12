package com.bounswe.group8.repository;

import com.bounswe.group8.model.FavouriteWord;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
public interface FavouriteWordRepository extends JpaRepository<FavouriteWord, Long> {
    List<FavouriteWord> findAllByUserId(Long userId);
}
