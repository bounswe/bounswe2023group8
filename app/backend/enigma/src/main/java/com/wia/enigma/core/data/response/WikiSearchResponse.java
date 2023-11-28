package com.wia.enigma.core.data.response;
import lombok.*;
import java.util.List;
import java.util.Map;

@Getter
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class WikiSearchResponse {
    int success;

    List<Map<String, Object>> search;
}