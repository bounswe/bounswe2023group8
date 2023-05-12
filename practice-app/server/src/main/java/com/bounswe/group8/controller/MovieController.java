package com.bounswe.group8.controller;
import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import com.bounswe.group8.payload.dto.MovieDto;


import com.bounswe.group8.service.MovieService;

@RestController
@RequestMapping("/api/movies")

public class MovieController {
    @Autowired
    private MovieService movieService;

    @GetMapping("/popular/{page}")
    public List<MovieDto> getPopularMovies(@PathVariable String page) throws IOException {
        return movieService.getPopularMovies(page);
    }
}