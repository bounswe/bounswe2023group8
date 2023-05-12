package com.bounswe.group8.payload.dto;

public class MovieDto {
    private String title;
    private Double rating;
    private String posterPath;
    private String releaseDate;

    public MovieDto(String title, Double rating, String posterPath, String releaseDate) {
        this.title = title;
        this.rating = rating;
        this.posterPath = posterPath;
        this.releaseDate = releaseDate;

    }

    public String getTitle() {
        return title;
    }

    public Double getRating() {
        return rating;
    }

    public String getPosterPath() {
        return posterPath;
    }

    public String getReleaseDate() {
        return releaseDate;
    }
}
