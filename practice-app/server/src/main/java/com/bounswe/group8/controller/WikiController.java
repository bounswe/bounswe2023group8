package com.bounswe.group8.controller;

import org.springframework.beans.factory.annotation.Autowired;
import com.bounswe.group8.service.WikiService;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/wiki")
public class WikiController {

    @Autowired
    private WikiService wikiService;

    @GetMapping("/search/{searchText}")
    public Object search(@PathVariable String searchText) {
        return wikiService.search(searchText);
    }
}
