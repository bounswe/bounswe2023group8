package com.wia.annotation.dal.repository;

import com.wia.annotation.dal.entity.AnnotationContainer;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AnnotationContainerRepository extends JpaRepository<AnnotationContainer, Long> {

    boolean existsByContainerName(String containerName);

    AnnotationContainer findByContainerName(String containerName);

    void deleteByContainerName(String containerName);
}
