package com.wia.annotation.core.service;

import com.wia.annotation.core.data.response.AnnotationContainerResponse;

import java.util.List;

public interface AnnotationContainerService {
    AnnotationContainerResponse createAnnotationContainer(String containerName,
                                                          List<String> type,
                                                          String label);

    AnnotationContainerResponse getAnnotationContainer(String containerName);

    void deleteAnnotationContainer(String containerName);
}
