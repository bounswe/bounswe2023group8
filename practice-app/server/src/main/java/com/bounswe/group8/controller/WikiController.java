package com.bounswe.group8.controller;

import com.bounswe.group8.model.Wiki;
import com.bounswe.group8.payload.request.PostCreateRequest;
import com.bounswe.group8.payload.WikiCreateRequest;
import com.bounswe.group8.payload.dto.PostDto;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
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
    @Operation(summary = "Search entity by id.", description = "Takes a string as a param and returns all related entities.", responses = { @ApiResponse(description = "List of entity objects.") })
    @GetMapping("/search/{searchText}")
    public Object searchEntityByText(@PathVariable String searchText) {
        if (searchText != null && !searchText.isEmpty()) {
            return wikiService.searchEntity(searchText);
        } else {
            return Collections.emptyList();
        }
    }
    @Operation(summary = "Get entity by id.", description = "Takes a string id as a param and returns the entity with that id.", responses = { @ApiResponse(description = "List of entity objects.") })
    @GetMapping("/entity/{id}")
    public Object getEntityById(@PathVariable String id){

        return wikiService.getEntity(id);
    }

    @Operation(summary = "Create bookmarks.", description = "Takes a JSON object with keys label and code in body and creates a bookmark.", responses = { @ApiResponse(description = "Status message.") })
    @PostMapping
    public ResponseEntity<String> createBookmark(
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

    @Operation(summary = "Create all bookmarks.", description = "Returns all bookmarks.", responses = { @ApiResponse(description = "List of bookmark objects.") })
    @GetMapping("/bookmarks/all")
    public ResponseEntity<List<Wiki>> getAllBookmarks() {
        return ResponseEntity.ok(
                wikiService.getAll()
        );
    }

    @Operation(summary = "Delete all bookmarks.", description = "Deletes all bookmarks.", responses = { @ApiResponse(description = "Status message.") })
    @DeleteMapping("/bookmarks/all")
    public ResponseEntity<String> deleteAllBookmarks() {
        wikiService.deleteAll();
        return ResponseEntity.ok("All bookmarks deleted successfully");
    }

    @Operation(summary = "Delete bookmark by code.", description = "Takes a string code as a param and deletes bookmarks with that id.", responses = { @ApiResponse(description = "Status message.") })
    @DeleteMapping("/bookmarks/{code}")
    public ResponseEntity<String> deleteBookmarksByCode(@PathVariable String code) {
        wikiService.deleteBookmark(code);
        return ResponseEntity.ok("Bookmark with code: "+ code +" deleted successfully");
    }



}
