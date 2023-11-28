package com.wia.enigma.core.data.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.util.Map;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WikiTagResponse {
    int success;

    private Map<String, WikiEntity> entities;

    @Getter
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class WikiEntity {
        private String id;

        private Map<String, LanguageValue> labels;

        private Map<String, LanguageValue> descriptions;

        @Getter
        @Builder
        @NoArgsConstructor
        @AllArgsConstructor
        public static class LanguageValue {
            private String language;
            private String value;
        }
    }
}


