package com.bounswe.group8.repository;

import com.bounswe.group8.model.Wiki;
import org.springframework.data.jpa.repository.JpaRepository;


public interface WikiRepository  extends JpaRepository<Wiki, Long> {

    Wiki findWikiById(String id);


    @Override
    void deleteAll();

    void deleteWikisByCode(String code);
}
