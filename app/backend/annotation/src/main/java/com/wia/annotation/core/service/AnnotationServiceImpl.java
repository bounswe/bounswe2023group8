package com.wia.annotation.core.service;

import com.wia.annotation.core.exceptions.Exceptions;
import com.wia.annotation.core.exceptions.custom.AnnotationServerDatabaseException;
import com.wia.annotation.dal.entity.Annotation;
import com.wia.annotation.dal.repository.AnnotationRepository;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class AnnotationServiceImpl implements AnnotationService {

    final AnnotationRepository annotationRepository;

    /**
     * Gets all annotations for a given annotation container.
     *
     * @param containerName name of the annotation container
     * @return              List of Annotation
     */
    @Override
    public List<Annotation> getAnnotations(String containerName) {
        try {
            return annotationRepository.findAllByContainerNameOrderById(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotations.");
        }
    }

    /**
     * Checks if an annotation container contains any annotations.
     *
     * @param containerName name of the annotation container
     * @return              Boolean
     */
    @Override
    public Boolean containsAnnotations(String containerName) {

        try {
            return annotationRepository.existsByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotations.");
        }
    }
}
