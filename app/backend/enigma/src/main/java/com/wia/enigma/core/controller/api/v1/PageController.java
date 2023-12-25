package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.ExplorePageDto;
import com.wia.enigma.core.data.dto.HomePageDto;
import com.wia.enigma.core.data.dto.ProfilePageDto;
import com.wia.enigma.core.service.PageService.PageService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class PageController {

    final PageService pageService;

    /*
        WA-16: Gets profile page.
     */
    @GetMapping("/profile")
    public ResponseEntity<?> getProfile(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        ProfilePageDto profilePageDto = pageService.getProfilePage(token.getEnigmaUserId(), id);

        return ResponseEntity.ok(profilePageDto);
    }

    /*
        WA-16: Gets home page.
     */
    @GetMapping("/home")
    public ResponseEntity<?> getHome(EnigmaAuthenticationToken token) {

        HomePageDto homePageDto = pageService.getHomePage(token.getEnigmaUserId());

        return ResponseEntity.ok(homePageDto);
    }

    /*
        WA-65: Gets explore page for visitor.
     */
    @GetMapping("/explore")
    public ResponseEntity<?> getExplore() {

        ExplorePageDto explorePageDto = pageService.getExplorePage();

        return ResponseEntity.ok(explorePageDto);
    }
}