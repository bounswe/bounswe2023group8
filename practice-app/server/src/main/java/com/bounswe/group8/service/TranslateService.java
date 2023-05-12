package com.bounswe.group8.service;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
// ...

import com.bounswe.group8.mapper.TranslateMapper;
import com.bounswe.group8.model.Translate;
import com.bounswe.group8.payload.TranslateCreateRequest;
import com.bounswe.group8.payload.dto.TranslateDto;
import com.bounswe.group8.repository.TranslateRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class TranslateService {

  final TranslateRepository translateRepository;

  public List<TranslateDto> getAll() {

    List<Translate> translates = translateRepository.findAll();
    
    return translates.stream()
      .map(TranslateMapper::translateToTranslateDto)
      .collect(Collectors.toList());
  }



  /**
   * Create translate.
   *
   * @param request   TranslateCreateRequest
   * @return          Translate id - created translate
  */
  public Long createTranslate(String request) {
    
    Translate translate = Translate.builder()
      .text(request)
      .build();

    Translate saved = translateRepository.save(translate);

    return saved.getId();
  }

}
