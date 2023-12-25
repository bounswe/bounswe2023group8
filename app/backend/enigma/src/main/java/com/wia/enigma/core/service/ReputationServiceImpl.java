package com.wia.enigma.core.service;


import com.wia.enigma.core.data.dto.ReputationVoteDto;
import com.wia.enigma.core.data.dto.UserBadgesDto;
import com.wia.enigma.core.service.PostService.PostService;
import com.wia.enigma.core.service.UserService.EnigmaUserService;
import com.wia.enigma.dal.entity.ReputationVote;
import com.wia.enigma.dal.enums.ExceptionCodes;
import com.wia.enigma.dal.repository.ReputationVoteRepository;
import com.wia.enigma.exceptions.custom.EnigmaException;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class ReputationServiceImpl implements ReputationService {

    final ReputationVoteRepository reputationVoteRepository;

    final EnigmaUserService enigmaUserService;
    final PostService postService;


    /**
     * Creates a new reputation vote for a user
     *
     * @param voterEnigmaUserId voter
     * @param votedEnigmaUserId voted
     * @param vote              vote value (1 - 5)
     * @param comment           comment
     */
    @Override
    public void voteOnUser(Long voterEnigmaUserId, Long votedEnigmaUserId, Integer vote, String comment) {

        enigmaUserService.validateExistence(voterEnigmaUserId);
        enigmaUserService.validateExistence(votedEnigmaUserId);

        if (vote < 1 || vote > 5)
            throw new IllegalArgumentException("Vote value must be between 1 and 5");

        if (voterEnigmaUserId.equals(votedEnigmaUserId))
            throw new IllegalArgumentException("Voter and voted cannot be the same user");

        if (comment != null && comment.length() > 255)
            throw new IllegalArgumentException("Comment cannot be longer than 255 characters");

        ReputationVote reputationVote;
        try {
            reputationVote = reputationVoteRepository.findByVoterEnigmaUserIdAndVotedEnigmaUserId(voterEnigmaUserId, votedEnigmaUserId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch reputation vote.");
        }

        if (reputationVote != null) {
            reputationVote.setVote(vote);
            reputationVote.setComment(comment);
        } else {
            reputationVote = ReputationVote.builder()
                    .voterEnigmaUserId(voterEnigmaUserId)
                    .votedEnigmaUserId(votedEnigmaUserId)
                    .vote(vote)
                    .comment(comment)
                    .createTime(new Timestamp(System.currentTimeMillis()))
                    .build();
        }

        try {
            reputationVoteRepository.save(reputationVote);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_SAVE_ERROR,
                    "Could not save reputation vote.");
        }
    }

    /**
     * Returns the reputation votes of a user
     *
     * @param enigmaUserId EnigmaUser.Id
     * @return ReputationVoteDto
     */
    @Override
    public ReputationVoteDto getReputationVotesOfUser(Long enigmaUserId) {

        List<ReputationVote> reputationVotes;
        try {
            reputationVotes = reputationVoteRepository.findAllByVotedEnigmaUserId(enigmaUserId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch total votes for user.");
        }

        if (reputationVotes == null)
            throw new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND,
                    "Reputation votes for user with id " + enigmaUserId + " do not exist.");

        if (reputationVotes.isEmpty())
            return null;

        Integer voteSum = reputationVotes.stream().mapToInt(ReputationVote::getVote).sum();
        int voteCount = reputationVotes.size();

        return ReputationVoteDto.builder()
                .enigmaUserId(enigmaUserId)
                .voteSum(voteSum)
                .voteCount(voteCount)
                .voteAverage((double) voteSum / voteCount)
                .votes(reputationVotes.stream()
                        .map(reputationVote -> ReputationVoteDto.Vote.builder()
                                .voterEnigmaUserId(reputationVote.getVoterEnigmaUserId())
                                .vote(reputationVote.getVote())
                                .comment(reputationVote.getComment() == null ? "" : reputationVote.getComment())
                                .createTime(reputationVote.getCreateTime())
                                .build())
                        .toList())
                .build();
    }

    /**
     * Gets the badges of a user
     *
     * @param enigmaUserId EnigmaUser.Id
     * @return UserBadgesDto
     */
    @Override
    public UserBadgesDto getBadgesForUser(Long enigmaUserId) {

        List<ReputationVote> reputationVotes;
        try {
            reputationVotes = reputationVoteRepository.findAllByVoterEnigmaUserId(enigmaUserId);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            throw new EnigmaException(ExceptionCodes.DB_GET_ERROR,
                    "Could not fetch total votes for user.");
        }

        if (reputationVotes == null)
            throw new EnigmaException(ExceptionCodes.ENTITY_NOT_FOUND,
                    "Reputation votes for user with id " + enigmaUserId + " do not exist.");

        UserBadgesDto userBadgesDto = new UserBadgesDto();
        userBadgesDto.setEnigmaUserId(enigmaUserId);

        Integer postCount = postService.getPostCount(enigmaUserId);
        userBadgesDto.setPostCount(postCount);

        int voteSum = reputationVotes.stream().mapToInt(ReputationVote::getVote).sum();
        userBadgesDto.setVoteSum(voteSum);

        double ratio;
        try {
            ratio = (double) (voteSum / postCount);
        } catch (Exception e) {
            ratio = voteSum;
        }
        userBadgesDto.setReputationRatio(ratio);


        /* Posts */
        List<UserBadgesDto.Badge> badges = new ArrayList<>();
        if (postCount >= 1)
            badges.add(new UserBadgesDto.Badge("First Post", "You posted your first post."));

        if (postCount >= 10)
            badges.add(new UserBadgesDto.Badge("5 Posts", "You posted 5 posts."));

        if (postCount >= 500)
            badges.add(new UserBadgesDto.Badge("500 Posts", "You posted 500 posts."));

        if (postCount >= 2500)
            badges.add(new UserBadgesDto.Badge("2000 Posts", "You posted 2000 posts."));

        if (postCount >= 10000)
            badges.add(new UserBadgesDto.Badge("10000 Posts", "You posted 10000 posts."));

        /* Reputation */
        if (voteSum >= 100)
            badges.add(new UserBadgesDto.Badge("100 Positive Votes", "You have a net total of 100 positive votes."));

        if (voteSum >= 1000)
            badges.add(new UserBadgesDto.Badge("1000 Positive Votes", "You have a net total of 1000 positive votes."));

        if (voteSum >= 10000)
            badges.add(new UserBadgesDto.Badge("10000 Positive Votes", "You have a net total of 10000 positive votes."));

        if (voteSum >= 100000)
            badges.add(new UserBadgesDto.Badge("100000 Positive Votes", "You have a net total of 100000 positive votes."));

        if (voteSum >= 1000000)
            badges.add(new UserBadgesDto.Badge("1000000 Positive Votes", "You have a net total of 1000000 positive votes."));

        userBadgesDto.setBadges(badges);

        /* Reputation Ratio */
        userBadgesDto.setReputation("Terrifying");

        if (ratio >= 0.01)
            userBadgesDto.setReputation("Terrible");

        if (ratio >= 0.1)
            userBadgesDto.setReputation("Poor");

        if (ratio >= 0.5)
            userBadgesDto.setReputation("Average");

        if (ratio >= 1)
            userBadgesDto.setReputation("Good");

        if (ratio >= 2)
            userBadgesDto.setReputation("Great");

        if (ratio >= 3)
            userBadgesDto.setReputation("Excellent");

        if (ratio >= 4)
            userBadgesDto.setReputation("Awesome");

        if (ratio >= 5)
            userBadgesDto.setReputation("Godlike");

        return userBadgesDto;
    }
}
