package com.wia.enigma.core.service.StorageService;

import org.springframework.web.multipart.MultipartFile;

public interface StorageService {

    String uploadFile(MultipartFile file,String bucketName, String fileName);
}
