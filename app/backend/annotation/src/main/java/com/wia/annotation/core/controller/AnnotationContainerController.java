package com.wia.annotation.core.controller;

import com.wia.annotation.core.data.request.CreateAnnotationContainerRequest;
import com.wia.annotation.core.service.AnnotationContainerServiceImpl;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping(path = "/wia", headers = "Allow: POST", produces = "application/ld+json", consumes = "application/ld+json")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class AnnotationContainerController {

    final AnnotationContainerServiceImpl annotationContainerService;

    @PostMapping(path = "/{containerName}")
    public ResponseEntity<?> createAnnotationContainer(@PathVariable String containerName,
                                                       @RequestBody CreateAnnotationContainerRequest request) {



        return ResponseEntity.ok().build();
    }


}
