package com.wia.annotation.core.service;

import com.wia.annotation.core.data.dto.AnnotationDto;
import com.wia.annotation.core.data.response.AnnotationContainerResponse;
import com.wia.annotation.core.exceptions.Exceptions;
import com.wia.annotation.core.exceptions.custom.AnnotationServerBadRequestException;
import com.wia.annotation.core.exceptions.custom.AnnotationServerDatabaseException;
import com.wia.annotation.dal.entity.Annotation;
import com.wia.annotation.dal.entity.AnnotationContainer;
import com.wia.annotation.dal.repository.AnnotationContainerRepository;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.sql.Timestamp;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class AnnotationContainerServiceImpl implements AnnotationContainerService {

    @Value("${annotation.page.size}")
    Integer pageSize;

    final AnnotationContainerRepository annotationContainerRepository;

    final AnnotationService annotationService;

    /**
     * Creates an annotation container.
     *
     * @param containerName name of the annotation container
     * @param type          type(s) of the annotation container
     * @param label         label of the annotation container
     * @return              AnnotationContainerResponse
     */
    @Override
    public AnnotationContainerResponse createAnnotationContainer(String containerName,
                                                                 List<String> type,
                                                                 String label) {

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        boolean exists = false;
        try {
            exists = annotationContainerRepository.existsByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotation container existence.");
        }

        if (exists)
            throw new AnnotationServerDatabaseException(Exceptions.DB_DUPLICATE_ERROR,
                    "Annotation container with name " + containerName + " already exists.");

        if (type == null || type.isEmpty())
            throw new AnnotationServerBadRequestException(Exceptions.BAD_REQUEST,
                    "Annotation container type cannot be empty.");

        if (!type.contains("AnnotationContainer"))
            throw new AnnotationServerBadRequestException(Exceptions.BAD_REQUEST,
                    "Annotation container type must contain AnnotationContainer.");

        if (label == null || label.isEmpty())
            throw new AnnotationServerBadRequestException(Exceptions.BAD_REQUEST,
                    "Annotation container label cannot be empty.");

        AnnotationContainer annotationContainer = AnnotationContainer.builder()
                .containerName(containerName)
                .label(label)
                .modified(new Timestamp(System.currentTimeMillis()))
                .build();

        try {
            annotationContainerRepository.save(annotationContainer);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_SAVE_ERROR,
                    "Could not save annotation container.");
        }

        String annotationContainerId = baseUrl + "/wia/" + containerName + "/";
        return AnnotationContainerResponse.builder()
                .id(annotationContainerId)
                .label(label)
                .first(AnnotationContainerResponse.First.builder()
                        .id(annotationContainerId + "?page=0")
                        .next(null)
                        .items(List.of())
                        .partOf(annotationContainerId)
                        .startIndex(0)
                        .build())
                .last(annotationContainer.getId().toString() + "?page=0")
                .total(0)
                .modified(annotationContainer.getModified())
                .build();
    }

    /**
     * Fetches an annotation container.
     *
     * @param containerName name of the annotation container
     * @return              AnnotationContainerResponse
     */
    @Override
    public AnnotationContainerResponse getAnnotationContainer(String containerName) {

        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

        boolean exists = false;
        try {
            exists = annotationContainerRepository.existsByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotation container existence.");
        }

        if (!exists)
            throw new AnnotationServerDatabaseException(Exceptions.NOT_FOUND,
                    "Annotation container with name " + containerName + " does not exist.");

        AnnotationContainer annotationContainer;
        try {
            annotationContainer = annotationContainerRepository.findByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotation container.");
        }

        List<Annotation> annotations = annotationService.getAnnotations(containerName);
        List<Annotation> annotationPage = annotations.subList(0, Math.min(annotations.size(), pageSize));
        int lastPage = annotations.size() / pageSize;

        String annotationContainerId = baseUrl + "/wia/" + containerName + "/";
        return AnnotationContainerResponse.builder()
                .id(annotationContainerId)
                .label(annotationContainer.getLabel())
                .first(AnnotationContainerResponse.First.builder()
                        .id(annotationContainerId + "?page=0")
                        .next(null)
                        .items(annotationPage
                                .stream()
                                .map(annotation ->
                                        AnnotationDto.builder()
                                                .id(baseUrl + "/wia/" + containerName + "/" + annotation.getAnnotationName())
                                                .type(annotation.getType())
                                                .body(AnnotationDto.Body.builder()
                                                        .value(annotation.getValue())
                                                        .build())
                                                .target(annotation.getTarget())
                                                .build())
                                .collect(Collectors.toList())
                        )
                        .partOf(annotationContainerId)
                        .startIndex(0)
                        .build())
                .last(annotationContainer.getId().toString() + "?page=" + lastPage)
                .total(annotations.size())
                .modified(annotationContainer.getModified())
                .build();
    }

    /**
     * Deletes an annotation container.
     *
     * @param containerName name of the annotation container
     */
    @Override
    @Transactional
    public void deleteAnnotationContainer(String containerName) {

        boolean exists = false;
        try {
            exists = annotationContainerRepository.existsByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_FETCH_ERROR,
                    "Could not fetch annotation container existence.");
        }

        if (!exists)
            throw new AnnotationServerDatabaseException(Exceptions.NOT_FOUND,
                    "Annotation container with name " + containerName + " does not exist.");

        if (annotationService.containsAnnotations(containerName))
            throw new AnnotationServerDatabaseException(Exceptions.METHOD_NOT_ALLOWED,
                    "Annotation container with name " + containerName + " is not empty.");

        try {
            annotationContainerRepository.deleteByContainerName(containerName);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new AnnotationServerDatabaseException(Exceptions.DB_DELETE_ERROR,
                    "Could not delete annotation container.");
        }
    }

}
