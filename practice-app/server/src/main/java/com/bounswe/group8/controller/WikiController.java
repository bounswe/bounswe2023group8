package com.bounswe.group8.controller;

import com.bounswe.group8.model.Wiki;
import com.bounswe.group8.payload.PostCreateRequest;
import com.bounswe.group8.payload.WikiCreateRequest;
import com.bounswe.group8.payload.dto.PostDto;
import org.springframework.beans.factory.annotation.Autowired;
import com.bounswe.group8.service.WikiService;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.lang.reflect.Array;
import java.util.Collections;
import java.util.List;

@RestController
@RequestMapping("/api/wiki")
public class WikiController {

    private final WikiService wikiService;

    @Autowired
    public WikiController(WikiService wikiService) {
        this.wikiService = wikiService;
    }

    @GetMapping("/search/{searchText}")
    public Object search(@PathVariable String searchText) {
        if (searchText != null && !searchText.isEmpty()) {
            return wikiService.searchEntity(searchText);
        } else {
            return Collections.emptyList();
        }
    }

    @GetMapping("/entity/{id}")
    public Object entity(@PathVariable String id){

        return wikiService.getEntity(id);
    }


    @PostMapping
    public ResponseEntity<String> createPost(
            @RequestBody WikiCreateRequest wikiCreateRequest) {

        Long bookmarkId = wikiService.createBookmark(wikiCreateRequest);

        if (bookmarkId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                        ServletUriComponentsBuilder
                                .fromCurrentRequest()
                                .path("/{id}")
                                .buildAndExpand(bookmarkId)
                                .toUri())
                .build();
    }


    @GetMapping("/bookmarks/all")
    public ResponseEntity<List<Wiki>> getAllBookmarks() {
        return ResponseEntity.ok(
                wikiService.getAll()
        );
    }


    @DeleteMapping("/bookmarks/all")
    public ResponseEntity<String> deleteAllBookmarks() {
        wikiService.deleteAll();
        return ResponseEntity.ok("All bookmarks deleted successfully");
    }


    @DeleteMapping("/bookmarks/{code}")
    public ResponseEntity<String> deleteBookmarksByCode(@PathVariable String code) {
        wikiService.deleteBookmark(code);
        return ResponseEntity.ok("Bookmark with code: "+ code +" deleted successfully");
    }



}
