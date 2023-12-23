package com.wia.annotation.core.service;

import com.wia.annotation.core.data.response.AnnotationResponse;
import com.wia.annotation.core.exceptions.Exceptions;
import com.wia.annotation.core.exceptions.custom.AnnotationServerDatabaseException;
import com.wia.annotation.dal.entity.Annotation;
import com.wia.annotation.dal.repository.AnnotationRepository;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

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

    /**
     * Creates an annotation.
     *
     * @param containerName name of the annotation container
     * @param name          name of the annotation
     * @param type          type of the annotation
     * @param value         value of the annotation
     * @param target        target of the annotation
     * @return              AnnotationResponse
     */
    @Override
    public AnnotationResponse createAnnotation(String containerName,
                                               String name,
                                               String type,
                                               String value,
                                               String target) {

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        Annotation annotation = Annotation.builder()
                .containerName(containerName)
                .annotationName(name)
                .type(type)
                .value(value)
                .target(target)
                .build();

        try {
            annotationRepository.save(annotation);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotations.");
        }

        return AnnotationResponse.builder()
                .id(baseUrl + "/wia/" + containerName + "/" + name + annotation.getId())
                .body(AnnotationResponse.Body.builder()
                        .value(value)
                        .build())
                .target(target)
                .build();
    }

    /**
     * Deletes an annotation.
     *
     * @param containerName name of the annotation container
     * @param name          name of the annotation
     */
    @Override
    @Transactional
    public void deleteAnnotation(String containerName,
                                 String name,
                                 Long id) {

        Annotation annotation;
        try {
            annotation = annotationRepository.findByContainerNameAndAnnotationNameAndId(containerName, name, id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotation.");
        }

        if (annotation == null)
            throw new AnnotationServerDatabaseException(Exceptions.NOT_FOUND,
                    "Annotation with name = " + name + " and id = " + id + " does not exist in container " + containerName + ".");

        try {
            annotationRepository.delete(annotation);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_DELETE_ERROR,
                    "Could not delete annotation.");
        }
    }

    /**
     * Gets an annotation.
     *
     * @param containerName name of the annotation container
     * @param name          name of the annotation
     * @param id            id of the annotation
     * @return              AnnotationResponse
     */
    @Override
    public AnnotationResponse getAnnotation(String containerName,
                                            String name,
                                            Long id) {

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        Annotation annotation;
        try {
            annotation = annotationRepository.findByContainerNameAndAnnotationNameAndId(containerName, name, id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotations.");
        }

        if (annotation == null)
            throw new AnnotationServerDatabaseException(Exceptions.NOT_FOUND,
                    "Annotation with name = " + name + " and id = " + id + " does not exist in container " + containerName + ".");

        return AnnotationResponse.builder()
                .id(baseUrl + "/wia/" + containerName + "/" + name + annotation.getId())
                .body(AnnotationResponse.Body.builder()
                        .value(annotation.getValue())
                        .build())
                .target(annotation.getTarget())
                .build();
    }

    /**
     * Updates an annotation.
     *
     * @param containerName name of the annotation container
     * @param name          name of the annotation
     * @param id            id of the annotation
     * @param value         value of the annotation
     * @param target        target of the annotation
     * @return              AnnotationResponse
     */
    @Override
    public AnnotationResponse updateAnnotation(String containerName,
                                               String name,
                                               Long id,
                                               String value,
                                               String target) {

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        Annotation annotation;
        try {
            annotation = annotationRepository.findByContainerNameAndAnnotationNameAndId(containerName, name, id);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotations.");
        }

        if (annotation == null)
            throw new AnnotationServerDatabaseException(Exceptions.NOT_FOUND,
                    "Annotation with name = " + name + " and id = " + id + " does not exist in container " + containerName + ".");


        boolean updated = false;
        if (value != null && !value.equals(annotation.getValue())) {
            annotation.setValue(value);
            updated = true;
        }

        if (target != null && !target.equals(annotation.getTarget())) {
            annotation.setTarget(target);
            updated = true;
        }

        if (updated) {
            try {
                annotationRepository.save(annotation);
            } catch (Exception e) {
                log.error(e.getMessage(), e);
                throw new AnnotationServerDatabaseException(Exceptions.DB_SAVE_ERROR,
                        "Could not save annotation.");
            }
        }

        return AnnotationResponse.builder()
                .id(baseUrl + "/wia/" + containerName + "/" + name + annotation.getId())
                .body(AnnotationResponse.Body.builder()
                        .value(value)
                        .build())
                .target(target)
                .build();
    }
}
