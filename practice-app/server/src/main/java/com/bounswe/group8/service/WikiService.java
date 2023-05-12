package com.bounswe.group8.service;

import com.bounswe.group8.exception.custom.ResourceNotFoundException;
import com.bounswe.group8.model.*;
import com.bounswe.group8.payload.request.PostCreateRequest;
import com.bounswe.group8.payload.WikiCreateRequest;
import com.bounswe.group8.repository.WikiRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.client.HttpClientErrorException;

import java.net.http.HttpHeaders;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Service
public class WikiService {

    private final RestTemplate restTemplate;
    private final String apiUrl;
    private final WikiRepository wikiRepository;

    public WikiService(WikiRepository wikiRepository) {
        this.apiUrl = "https://www.wikidata.org/w/api.php";
        this.restTemplate = new RestTemplate();
        this.wikiRepository = wikiRepository;
    }

    public ResponseEntity<List<Map<String, Object>>> searchEntity(String searchText) {

        String url = apiUrl + "?action=wbsearchentities&format=json&search="
                + searchText + "&language=en&uselang=en&type=item";

        try {
            WikiSearchResponse response = restTemplate.getForObject(url,  WikiSearchResponse.class);
            if (response != null && response.getSuccess() == 1) {
                    System.out.println("Request successful. \t api/wiki/search/"+searchText);
                    return ResponseEntity.ok(response.getSearch());

            } else {
                System.out.println("Request unsuccessful. \t api/wiki/search/"+searchText);
                return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
            }
        } catch (HttpClientErrorException ex) {
            // Handle invalid response or exception
            return ResponseEntity.status(ex.getStatusCode()).build();
        } catch (Exception ex) {
            // Handle other exceptions
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }

    public ResponseEntity<Map<String, Object>> getEntity(String id) {

        String url = apiUrl + "?action=wbgetentities&ids="
                + id + "&format=json";

        try {
            WikiEntity response = restTemplate.getForObject(url,  WikiEntity.class);
            if (response != null && response.getSuccess() == 1) {
                System.out.println("Request successful. \t api/wiki/entity/"+id);
                return ResponseEntity.ok(response.getEntities());

            } else {
                System.out.println("Request unsuccessful. \t api/wiki/entity/"+id);
                return ResponseEntity.status(HttpStatus.NO_CONTENT).build();
            }
        } catch (HttpClientErrorException ex) {
            // Handle invalid response or exception
            return ResponseEntity.status(ex.getStatusCode()).build();
        } catch (Exception ex) {
            // Handle other exceptions
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }


    public Long createBookmark(WikiCreateRequest request) {


        Wiki wiki = Wiki.builder()
                .label(request.getLabel())
                .code(request.getCode())
                .build();

        Wiki saved = wikiRepository.save(wiki);
        System.out.println("Request successful. \t api/wiki");

        return saved.getId();
    }

    public List<Wiki> getAll() {

        List<Wiki> bookmarks = wikiRepository.findAll();

        System.out.println("Request successful. \t api/wiki/all");


        return bookmarks.stream().collect(Collectors.toList());
    }

    @Transactional
    public void deleteAll() {
        wikiRepository.deleteAll();
    }

    @Transactional
    public void deleteBookmark(String code) {
        wikiRepository.deleteWikisByCode(code);
    }


}
