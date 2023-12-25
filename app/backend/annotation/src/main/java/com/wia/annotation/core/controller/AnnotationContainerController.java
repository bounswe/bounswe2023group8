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
        produces = "application/ld+json",
        consumes = "application/ld+json")
@CrossOrigin(origins = "*")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnotationContainerController {

    final AnnotationContainerServiceImpl annotationContainerService;

    /**
     * C1: Creates an annotation container.
     *
     * @param request       CreateAnnotationContainerRequest
     * @return              HTTP 201
     */
    @PostMapping
    public ResponseEntity<?> createAnnotationContainer(@RequestBody CreateAnnotationContainerRequest request) {

        AnnotationContainerResponse response =
                annotationContainerService.createAnnotationContainer(
                        request.getName(),
                        request.getType(),
                        request.getLabel()
                );

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/wai/{containerName}")
                                .buildAndExpand(request.getName())
                                .toUri()
                )
                .body(response);
    }

    /**
     * C2: Gets an annotation container.
     *
     * @param containerName name of the annotation container
     * @return              HTTP 200
     */
    @GetMapping(path = "/{containerName}")
    public ResponseEntity<?> getAnnotationContainer(@PathVariable String containerName,
                                                    @RequestParam(defaultValue = "0") Integer page) {

        AnnotationContainerResponse response =
                annotationContainerService.getAnnotationContainer(containerName, page);

        return ResponseEntity
                .ok()
                .body(response);
    }

    /**
     * C3: Deletes an annotation container.
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
