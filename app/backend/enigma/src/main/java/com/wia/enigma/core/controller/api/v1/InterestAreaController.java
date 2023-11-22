package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.InterestAreaDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.request.CreateInterestAreaRequest;
import com.wia.enigma.core.service.InterestAreaService.InterestAreaService;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;
import java.util.Map;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/interest-area")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaController {

    final InterestAreaService interestAreaService;

    /*
        WA-8: Gets interest areas.
     */
    @GetMapping()
    public ResponseEntity<?> getInterestArea(@Valid  @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token ) {

        InterestAreaDto interestAreaDto = interestAreaService.getInterestArea(id,  token.getEnigmaUserId());

        return ResponseEntity.ok(interestAreaDto);

    }

    /*
        WA-9: Creates interest area.
     */
    @PostMapping()
    public ResponseEntity<?> createInterestArea(@RequestBody @Valid @NotNull CreateInterestAreaRequest createInterestAreaRequest, EnigmaAuthenticationToken token) {

        InterestAreaSimpleDto interestAreaSimpleDto = interestAreaService.createInterestArea(
                token.getEnigmaUserId(),
                createInterestAreaRequest.getTitle(),
                createInterestAreaRequest.getDescription(),
                createInterestAreaRequest.getAccessLevel(),
                createInterestAreaRequest.getNestedInterestAreas(),
                createInterestAreaRequest.getWikiTags()
        );

        return ResponseEntity
                .created(
                        ServletUriComponentsBuilder
                                .fromCurrentContextPath()
                                .path("/api/v1/interest-area/{id}")
                                .buildAndExpand(interestAreaSimpleDto.getId())
                                .toUri()
                )
                .body(interestAreaSimpleDto);
    }

    /*
        WA-10: Updates interest area.
     */
    @PutMapping()
    public ResponseEntity<?> updateInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, @RequestBody @Valid @NotNull CreateInterestAreaRequest createInterestAreaRequest) {

        InterestAreaSimpleDto interestAreaSimpleDto = interestAreaService.updateInterestArea(
                id,
                createInterestAreaRequest.getTitle(),
                createInterestAreaRequest.getDescription(),
                createInterestAreaRequest.getAccessLevel(),
                createInterestAreaRequest.getNestedInterestAreas(),
                createInterestAreaRequest.getWikiTags()
        );

        return ResponseEntity.ok(interestAreaSimpleDto);

    }

    /*
        WA-11: Deletes interest area.
     */
    @DeleteMapping()
    public ResponseEntity<?> deleteInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id) {

        interestAreaService.deleteInterestArea(id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-14: Follows interest area.
     */
    @GetMapping("follow")
    public ResponseEntity<?> followInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.followInterestArea(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-15: Unfollows interest area.
     */
    @GetMapping("unfollow")
    public ResponseEntity<?> unfollowInterestArea(@Valid @NotNull @RequestParam(name = "id") Long id, EnigmaAuthenticationToken token) {

        interestAreaService.unfollowInterestArea(token.getEnigmaUserId(), id);

        return ResponseEntity.ok().build();
    }

    /*
        WA-17: Searches interest areas.
     */
    @GetMapping("/search")
    public ResponseEntity<?>  searchInterestArea(@Valid @NotNull @RequestParam(name = "searchKey") String searchKey,  EnigmaAuthenticationToken token) {

        List<InterestAreaSimpleDto> search = interestAreaService.search(token.getEnigmaUserId(), searchKey);

        return ResponseEntity.ok(search);
    }

}
