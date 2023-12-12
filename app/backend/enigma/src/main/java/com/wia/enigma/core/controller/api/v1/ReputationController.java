package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.ReputationVoteDto;
import com.wia.enigma.core.data.request.VoteRequest;
import com.wia.enigma.core.service.ReputationService;
import jakarta.validation.Valid;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

@Slf4j
@Validated
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/reputation")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReputationController {

    final ReputationService reputationService;

    /*
        WA-45: Vote on a user or a post
     */
    @PostMapping("/vote")
    public ResponseEntity<?> vote(EnigmaAuthenticationToken token,
                                  @RequestBody @Valid VoteRequest voteRequest) {

        if (voteRequest.getVotedEnigmaUserId() != null && voteRequest.getPostId() != null)
            throw new IllegalArgumentException("Only one of votedEnigmaUserId and postId must be provided");

        if (voteRequest.getVotedEnigmaUserId() == null && voteRequest.getPostId() == null)
            throw new IllegalArgumentException("One of votedEnigmaUserId and postId must be provided");

        if (voteRequest.getVotedEnigmaUserId() != null)
            reputationService.voteOnUser(token.getEnigmaUserId(), voteRequest.getVotedEnigmaUserId(),
                    voteRequest.getVote(), voteRequest.getComment());
        else
            reputationService.voteOnPost(token.getEnigmaUserId(), voteRequest.getPostId(), voteRequest.getVote(),
                    voteRequest.getComment());

        return ResponseEntity.noContent().build();
    }

    /*
        WA-46: Get reputation votes of a user
     */
    @GetMapping
    public ResponseEntity<?> getReputation(EnigmaAuthenticationToken token,
                                           @RequestParam Long enigmaUserId) {

        ReputationVoteDto dto = reputationService.getReputationVotesOfUser(enigmaUserId);

        if (dto == null)
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(dto);
    }

    /*
        WA-47: Get badges of a user
     */
    @GetMapping("/badges")
    public ResponseEntity<?> getBadges(EnigmaAuthenticationToken token,
                                       @RequestParam Long enigmaUserId) {

        return ResponseEntity.ok(reputationService.getBadgesForUser(enigmaUserId));
    }
}
