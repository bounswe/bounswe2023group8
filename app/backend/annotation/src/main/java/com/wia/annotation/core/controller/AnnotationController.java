package com.wia.annotation.core.controller;

import com.wia.annotation.core.data.request.CreateAnnotationRequest;
import com.wia.annotation.core.data.response.AnnotationResponse;
import com.wia.annotation.core.service.AnnotationService;
import com.wia.annotation.utilities.StringUtils;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(
        path = "/wia",
        headers =
                "Accept: application/ld+json; " +
                        "profile=\"http://www.w3.org/ns/anno.jsonld\"" +
                        "Content-Type: application/ld+json; " +
                        "profile=\"http://www.w3.org/ns/anno.jsonld\"",
        produces = "application/ld+json",
        consumes = "application/ld+json")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnotationController {

    final AnnotationService annotationService;

    /**
     * Creates an annotation.
     *
     * @param containerName name of the annotation container
     * @param request       CreateAnnotationRequest
     * @return              HTTP 201
     */
    @PostMapping(path = "/{containerName}")
    public ResponseEntity<?> createAnnotation(@PathVariable String containerName,
                                              @RequestBody CreateAnnotationRequest request) {

        AnnotationResponse response =
                annotationService.createAnnotation(
                        containerName,
                        request.getBody().getName(),
                        request.getType(),
                        request.getBody().getValue(),
                        request.getTarget()
                );

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/wai/{containerName}/annotation/{annotationName}{annotationId}")
                                .buildAndExpand(containerName, request.getBody().getName(), response.getId())
                                .toUri()
                )
                .body(response);
    }

    /**
     * Gets an annotation.
     *
     * @param containerName     name of the annotation container
     * @param annotationNameId  name and id of the annotation
     * @return                  AnnotationResponse
     */
    @GetMapping(path = "/{containerName}/annotation/{annotationNameId}")
    public ResponseEntity<?> getAnnotation(@PathVariable String containerName,
                                           @PathVariable String annotationNameId) {

        AnnotationResponse response =
                annotationService.getAnnotation(
                        containerName,
                        StringUtils.divideFirst(annotationNameId),
                        StringUtils.divideSecond(annotationNameId)
                );

        return ResponseEntity
                .ok()
                .body(response);
    }

    /**
     * Deletes an annotation.
     *
     * @param containerName     name of the annotation container
     * @param annotationNameId  name and id of the annotation
     * @return                  HTTP 204
     */
    @PutMapping(path = "/{containerName}/annotation/{annotationNameId}")
    public ResponseEntity<?> updateAnnotation(@PathVariable String containerName,
                                              @PathVariable String annotationNameId,
                                              @RequestBody CreateAnnotationRequest request) {

        AnnotationResponse response =
                annotationService.updateAnnotation(
                        containerName,
StringUtils.divideFirst(annotationNameId),
                        StringUtils.divideSecond(annotationNameId),
                        request.getBody().getValue(),
                        request.getTarget()
                );

        return ResponseEntity
                .ok()
                .body(response);
    }

    /**
     * Deletes an annotation.
     *
     * @param containerName     name of the annotation container
     * @param annotationNameId  name and id of the annotation
     * @return                  HTTP 204
     */
    @DeleteMapping(path = "/{containerName}/annotation/{annotationNameId}")
    public ResponseEntity<?> deleteAnnotation(@PathVariable String containerName,
                                              @PathVariable String annotationNameId) {

        annotationService.deleteAnnotation(
                containerName,
                StringUtils.divideFirst(annotationNameId),
                StringUtils.divideSecond(annotationNameId)
        );

        return ResponseEntity
                .noContent()
                .build();
    }
}
