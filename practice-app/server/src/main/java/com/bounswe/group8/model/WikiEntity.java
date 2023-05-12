package com.bounswe.group8.model;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.List;
import java.util.Map;



public class WikiEntity {

    private int success;
    private Map<String, Object> entities;

    // Getters and setters

    public WikiEntity() {
    }

    public WikiEntity(int success, Map<String, Object> entities) {
        this.success = success;
        this.entities = entities;
    }

    public static WikiEntity fromJson(String json) {
        try {
            ObjectMapper objectMapper = new ObjectMapper();
            return objectMapper.readValue(json, WikiEntity.class);
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

    public Map<String, Object> getEntities() {
        return entities;
    }

    public void setEntities(Map<String, Object> entities) {
        this.entities = entities;
    }
}
