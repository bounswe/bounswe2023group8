package com.wia.annotation.dal.repository;

import com.wia.annotation.dal.entity.Annotation;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface AnnotationRepository extends JpaRepository<Annotation, Long> {

    List<Annotation> findAllByContainerNameOrderById(String containerName);

    Boolean existsByContainerName(String containerName);
}
