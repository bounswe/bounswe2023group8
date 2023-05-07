package com.bounswe.group8.service;

import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.net.http.HttpHeaders;
import java.util.Arrays;

@Service
public class WikiService {

/*    public String[] search(String searchText) {
        // Here, you can put your code to perform the search based on the given searchText.
        // For example, you could call an external API to search a wiki database.

        // For now, let's just return a simple message indicating that the search was successful:
        if(searchText.length() ==0){ return new String[]{};};

        return new String[]{"abc", "bcd", "casdfasd", "dasdfasd"};
    }*/


    public Object search(String searchText) {
        RestTemplate restTemplate = new RestTemplate();

        String url = "https://www.wikidata.org/w/api.php?action=wbsearchentities&format=json&search="
                + searchText + "&language=en&uselang=en&type=item";

        String result = restTemplate.getForObject(url, String.class);



        return result;
    }
}
