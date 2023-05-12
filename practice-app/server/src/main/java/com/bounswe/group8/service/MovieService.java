package com.bounswe.group8.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import com.bounswe.group8.payload.dto.MovieDto;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

@Service
public class MovieService {

    @Value("${tmdb.api.key}")
    private String apiKey;
    private String apiUrl = "https://api.themoviedb.org/3";

    public List<MovieDto> getPopularMovies(String page) throws IOException {
        // Build the API URL for the request
        String url = String.format("%s/movie/popular", apiUrl);
        url += "?api_key=" + apiKey;
        url += "&language=en-US";
        //page number
        url += "&page=" + page;

        // Make the API request
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Arrays.asList(org.springframework.http.MediaType.APPLICATION_JSON));
        headers.set("Authorization", "Bearer " + apiKey);
        org.springframework.http.HttpEntity<String> entity = new org.springframework.http.HttpEntity<String>("parameters", headers);
        org.springframework.http.ResponseEntity<String> response = restTemplate.exchange(url, org.springframework.http.HttpMethod.GET, entity, String.class);

        // Parse the response body
        ObjectMapper objectMapper = new ObjectMapper();
        com.fasterxml.jackson.databind.JsonNode rootNode = objectMapper.readTree(response.getBody());

        // Get the results array
        JsonNode resultsNode = rootNode.path("results");

        // Convert the results array to a list of MovieDto objects
        List<MovieDto> movieList = new ArrayList<>();
        for (JsonNode resultNode : resultsNode) {
            String title = resultNode.path("title").asText();
            Double rating = resultNode.path("vote_average").asDouble();
            String posterPath = resultNode.path("poster_path").asText();
            String releaseDate = resultNode.path("release_date").asText();
            movieList.add(new MovieDto(title, rating, posterPath, releaseDate));
        }

        return movieList;
    }
}