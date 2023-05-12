package com.bounswe.group8.model;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Map;

public class WikiSearchResponse {
    private int success;
    private List<Map<String, Object>> search;

    // Getters and setters

    public WikiSearchResponse() {
    }

    public WikiSearchResponse(int success, List<Map<String, Object>> search) {
        this.success = success;
        this.search = search;
    }

    public static WikiSearchResponse fromJson(String json) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(json, WikiSearchResponse.class);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public int getSuccess() {
        return success;
    }

    public void setSuccess(int success) {
        this.success = success;
    }

    public List<Map<String, Object>> getSearch() {
        return search;
    }

    public void setSearch(List<Map<String, Object>> search) {
        this.search = search;
    }
}
