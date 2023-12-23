package com.wia.annotation.core.service;

import com.wia.annotation.core.data.response.AnnotationResponse;
import com.wia.annotation.dal.entity.Annotation;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

public interface AnnotationService {

    List<Annotation> getAnnotations(String containerName);

    Boolean containsAnnotations(String containerName);

    AnnotationResponse createAnnotation(String containerName,
                                        String name,
                                        String type,
                                        String value,
                                        String target);

    @Transactional
    void deleteAnnotation(String containerName,
                          String name,
                          Long id);

    AnnotationResponse getAnnotation(String containerName,
                                     String name,
                                     Long id);

    AnnotationResponse updateAnnotation(String containerName,
                                        String name,
                                        Long id,
                                        String value,
                                        String target);
}
