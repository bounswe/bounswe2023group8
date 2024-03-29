package com.wia.enigma.core.service.WikiService;

import com.wia.enigma.core.data.response.WikiTagResponse;
import com.wia.enigma.core.data.response.WikiSearchResponse;
import com.wia.enigma.dal.entity.WikiTag;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.exceptions.custom.EnigmaException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WikiServiceImpl implements WikiService {

    @Value("${wiki.api.url}")
    String wikiApiUrl;

    final RestTemplate restTemplate=new RestTemplate();

    public List<Map<String, Object>> searchWikiTags(String searchText) {
        String url = constructWikiSearchApiUrl(searchText);

        try {
            WikiSearchResponse response = restTemplate.getForObject(url, WikiSearchResponse.class);

            if (response != null && response.getSuccess() == 1) {
                return response.getSearch();
            } else {
                throw new EnigmaException(ExceptionCodes.API_RETURNED_NON_200,  "Wiki API responded non-success.");
            }
        }catch (Exception ex) {
            log.error("Exception occurred during wiki API call: ", ex);
            throw new EnigmaException(ExceptionCodes.INTERNAL_SERVER_ERROR, "Error occurred while fetching wiki tags.");
        }
    }

    @Override
    public List<WikiTag> getWikiTags(List<String> ids) {
        String url = constructWikiGetApiUrl(ids);

        WikiTagResponse response;
        try {
            response = restTemplate.getForObject(url, WikiTagResponse.class);
        }catch (Exception ex) {
            log.error("Exception occurred during wiki API call: ", ex);
            throw new EnigmaException(ExceptionCodes.INTERNAL_SERVER_ERROR, "Error occurred while fetching wiki tags.");
        }

        if (response != null && response.getSuccess() == 1) {
            return ids.stream()
                    .map(id -> createWikiTag(response, id))
                    .collect(Collectors.toList());
        } else {
            // Handle the case where the response is not successful
            log.error("Wiki API responded non-success.");
            throw new EnigmaException(ExceptionCodes.INVALID_WIKI_TAG_ID, "Invalid wiki tag id.");
        }
    }

    private WikiTag createWikiTag(WikiTagResponse response, String id) {
        if (response.getEntities().containsKey(id)) {
            WikiTagResponse.WikiEntity entity = response.getEntities().get(id);
            String label = entity.getLabels() != null && entity.getLabels().containsKey("en")
                    ? entity.getLabels().get("en").getValue() : "";
            String description = entity.getDescriptions() != null && entity.getDescriptions().containsKey("en")
                    ? entity.getDescriptions().get("en").getValue() : "";

            return WikiTag.builder()
                    .id(id)
                    .label(label)
                    .description(description)
                    .isValidTag(!label.isEmpty())
                    .build();
        } else {
            throw new EnigmaException(ExceptionCodes.INVALID_WIKI_TAG_ID, "Invalid wiki tag id: " + id);
        }
    }

    private String constructWikiSearchApiUrl(String searchText) {
        return wikiApiUrl + "?action=wbsearchentities&format=json&search="
                + searchText + "&language=en&uselang=en&type=item";
    }

    private String constructWikiGetApiUrl(List<String> ids) {

        return wikiApiUrl + "?action=wbgetentities&ids="
                + String.join("|", ids) + "&format=json&languages=en&uselang=en&props=labels|descriptions";
    }
}