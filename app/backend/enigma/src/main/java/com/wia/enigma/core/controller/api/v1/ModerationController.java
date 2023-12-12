package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.configuration.security.EnigmaAuthenticationToken;
import com.wia.enigma.core.data.dto.ModerationDto;
import com.wia.enigma.core.data.request.ModerationRequest;
import com.wia.enigma.core.data.request.ReportRequest;
import com.wia.enigma.core.service.ModerationService;
import com.wia.enigma.dal.enums.ModerationType;
import com.wia.enigma.utilities.AuthUtils;
import jakarta.validation.Valid;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/moderation")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ModerationController {

    final ModerationService moderationService;

    /*
        WA-48: Remove the post from the interest area.
     */
    @DeleteMapping("/post")
    public ResponseEntity<?> deletePost(EnigmaAuthenticationToken token,
                                        @Valid @NotNull @RequestParam Long postId) {

        moderationService.removePost(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                postId
        );

        return ResponseEntity.noContent().build();
    }

    /*
        WA-49: Remove the interest area.
     */
    @DeleteMapping("/interest-area")
    public ResponseEntity<?> deleteInterestArea(EnigmaAuthenticationToken token,
                                                @Valid @NotNull @RequestParam Long interestAreaId) {

        moderationService.removeInterestArea(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                interestAreaId
        );

        return ResponseEntity.noContent().build();
    }

    /*
        WA-50: Warn the user.
     */
    @PostMapping("/warn")
    public ResponseEntity<?> warnUser(EnigmaAuthenticationToken token,
                                      @RequestBody ModerationRequest inDto) {

        moderationService.warnUser(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                inDto.getUserId(),
                inDto.getPostId(),
                inDto.getReason()
        );

        return ResponseEntity.noContent().build();
    }

    /*
        WA-51: Ban the user.
     */
    @PostMapping("/ban")
    public ResponseEntity<?> banUser(EnigmaAuthenticationToken token,
                                     @RequestBody ModerationRequest inDto) {

        moderationService.banUser(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                inDto.getUserId(),
                inDto.getPostId(),
                inDto.getReason()
        );

        return ResponseEntity.noContent().build();
    }

    /*
        WA-52: Unban the user.
     */
    @DeleteMapping("/unban")
    public ResponseEntity<?> unbanUser(EnigmaAuthenticationToken token,
                                       @Valid @NotNull @RequestParam Long userId,
                                       @Valid @NotNull @RequestParam Long interestAreaId) {

           moderationService.unbanUser(
                     AuthUtils.getInstance().buildEnigmaAuthorities(token),
                     userId,
                     interestAreaId
           );

           return ResponseEntity.noContent().build();
    }

    /*
        WA-53: Report an issue.
     */
    @PostMapping("/report")
    public ResponseEntity<?> reportIssue(EnigmaAuthenticationToken token,
                                         @RequestBody ReportRequest inDto) {

        moderationService.reportIssue(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                inDto.getUserId(),
                inDto.getPostId(),
                inDto.getInterestAreaId(),
                inDto.getReason()
        );

        return ResponseEntity.noContent().build();
    }

    /*
        WA-54: Get moderations.
     */
    @GetMapping
    public ResponseEntity<?> getModerations(EnigmaAuthenticationToken token,
                                            @RequestParam(required = false) String type,
                                            @RequestParam(required = false) Long interestAreaId,
                                            @RequestParam(required = false) Long postId,
                                            @RequestParam(required = false) Long toUserId,
                                            @RequestParam(required = false) Long fromUserId) {


        List<ModerationDto> moderations = moderationService.getModeration(
                AuthUtils.getInstance().buildEnigmaAuthorities(token),
                ModerationType.fromString(type),
                interestAreaId,
                postId,
                toUserId,
                fromUserId
        );

        if (moderations == null || moderations.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok(moderations);
    }
}
