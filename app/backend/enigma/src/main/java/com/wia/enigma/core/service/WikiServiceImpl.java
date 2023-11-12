package com.wia.enigma.core.service;

import com.wia.enigma.core.data.response.WikiSearchResponse;
import com.wia.enigma.dal.enums.ExceptionCodes;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import lombok.extern.slf4j.Slf4j;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.AccessLevel;
import com.wia.enigma.exceptions.custom.EnigmaApiException;

import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WikiServiceImpl implements WikiService {

    @Value("${wiki.api.url}")
    String wikiApiUrl;

    final RestTemplate restTemplate=new RestTemplate();

    public List<Map<String, Object>> searchWikiTags(String searchText) {
        String url = constructWikiApiUrl(searchText);

        try {
            WikiSearchResponse response = restTemplate.getForObject(url, WikiSearchResponse.class);

            if (response != null && response.getSuccess() == 1) {
                return response.getSearch();
            } else {
                throw new EnigmaApiException(ExceptionCodes.API_RETURNED_NON_200,  "Wiki API responded non-success.");
            }
        }catch (Exception ex) {
            log.error("Exception occurred during wiki API call: ", ex);
            throw new EnigmaApiException(ExceptionCodes.INTERNAL_SERVER_ERROR, "Error occurred while fetching wiki tags.");
        }
    }

    private String constructWikiApiUrl(String searchText) {
        return wikiApiUrl + "?action=wbsearchentities&format=json&search="
                + searchText + "&language=en&uselang=en&type=item";
    }
}