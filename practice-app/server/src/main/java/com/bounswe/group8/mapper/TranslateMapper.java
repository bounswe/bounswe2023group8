package com.bounswe.group8.mapper;

import com.bounswe.group8.model.Translate;
import com.bounswe.group8.payload.dto.TranslateDto;

public class TranslateMapper {

    public static TranslateDto translateToTranslateDto(Translate translate) {
        return new TranslateDto()
                .setId(translate.getId())
                .setText(translate.getText());
    }

}
