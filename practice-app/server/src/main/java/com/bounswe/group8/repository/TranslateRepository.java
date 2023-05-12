package com.bounswe.group8.repository;

import com.bounswe.group8.model.Translate;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TranslateRepository extends JpaRepository<Translate, Long> {

    Translate findTranslateById(Long id);
}
