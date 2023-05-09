package com.bounswe.group8.controller;

import com.bounswe.group8.model.IP;
import com.bounswe.group8.payload.IPCreateRequest;
import com.bounswe.group8.payload.dto.IPDto;
import com.bounswe.group8.service.IPService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

@RestController
@RequestMapping("/api/ip")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class IPController {

    final IPService ipService;

    /**
     * Creates a new row contains ip details
     *
     * @param ipCreateRequest create request
     * @return IPDto - created IP
     */
    @PostMapping
    public ResponseEntity<IPDto> createIP(
            @RequestBody IPCreateRequest ipCreateRequest) {

        Long ipID = ipService.createIP(ipCreateRequest).getId();

        if (ipID == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(ipID)
                        .toUri())
                .build();
    }

    /**
     *
     * @param title String title
     * @return Integer
     */
    @GetMapping("/details/{ip}")
    public ResponseEntity<IP> getDetailsByIP(
            @PathVariable String ip) {

        IP ipDetails = ipService.getDetailsForIP(ip);

        return ResponseEntity.ok().body(ipDetails);
    }
}