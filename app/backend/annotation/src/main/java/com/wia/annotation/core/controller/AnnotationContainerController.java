package com.wia.annotation.core.controller;

import com.wia.annotation.core.data.request.CreateAnnotationContainerRequest;
import com.wia.annotation.core.data.response.AnnotationContainerResponse;
import com.wia.annotation.core.service.AnnotationContainerServiceImpl;
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
public class AnnotationContainerController {

    final AnnotationContainerServiceImpl annotationContainerService;

    /**
     * Creates an annotation container.
     *
     * @param containerName name of the annotation container
     * @param request       CreateAnnotationContainerRequest
     * @return              HTTP 201
     */
    @PostMapping(path = "/{containerName}")
    public ResponseEntity<?> createAnnotationContainer(@PathVariable String containerName,
                                                       @RequestBody CreateAnnotationContainerRequest request) {

        AnnotationContainerResponse response =
                annotationContainerService.createAnnotationContainer(
                        containerName,
                        request.getType(),
                        request.getLabel()
                );

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/wai/{containerName}")
                                .buildAndExpand(containerName)
                                .toUri()
                )
                .body(response);
    }

    /**
     * Gets an annotation container.
     *
     * @param containerName name of the annotation container
     * @return              HTTP 200
     */
    @GetMapping(path = "/{containerName}")
    public ResponseEntity<?> getAnnotationContainer(@PathVariable String containerName) {

        AnnotationContainerResponse response =
                annotationContainerService.getAnnotationContainer(containerName);

        return ResponseEntity
                .ok()
                .body(response);
    }

    /**
     * Deletes an annotation container.
     *
     * @param containerName name of the annotation container
     * @return              HTTP 204
     */
    @DeleteMapping(path = "/{containerName}")
    public ResponseEntity<?> deleteAnnotationContainer(@PathVariable String containerName) {

        annotationContainerService.deleteAnnotationContainer(containerName);

        return ResponseEntity
                .noContent()
                .build();
    }
}
