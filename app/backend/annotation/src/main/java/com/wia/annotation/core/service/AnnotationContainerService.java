package com.wia.annotation.core.service;

import com.wia.annotation.core.data.response.AnnotationContainerResponse;

import java.util.List;

public interface AnnotationContainerService {

    AnnotationContainerResponse createAnnotationContainer(String containerName,
                                                          List<String> type,
                                                          String label);

    AnnotationContainerResponse getAnnotationContainer(String containerName,
                                                       Integer page);

    void deleteAnnotationContainer(String containerName);

    Boolean annotationContainerExists(String containerName);

    void updateAnnotationContainerModified(String containerName);
}
