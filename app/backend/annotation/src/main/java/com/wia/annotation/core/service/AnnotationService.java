package com.wia.annotation.core.service;

import com.wia.annotation.dal.entity.Annotation;

import java.util.List;

public interface AnnotationService {
    List<Annotation> getAnnotations(String containerName);

    Boolean containsAnnotations(String containerName);
}
