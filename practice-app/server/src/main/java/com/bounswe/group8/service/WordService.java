package com.bounswe.group8.service;

import com.bounswe.group8.model.FavouriteWord;
import com.bounswe.group8.model.User;
import com.bounswe.group8.payload.AddFavRequest;
import com.bounswe.group8.payload.WordMeaningResponse;
import com.bounswe.group8.payload.dto.FavouriteWordDto;
import com.bounswe.group8.payload.dto.WordMeaningDto;
import com.bounswe.group8.repository.FavouriteWordRepository;
import com.bounswe.group8.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class WordService {

    final FavouriteWordRepository favouriteWordRepository;

    final UserRepository userRepository;

    final String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";

    public WordMeaningDto getWordMeaning(String word) {

        String url = baseUrl + word;
        RestTemplate restTemplate = new RestTemplate();
        ResponseEntity<WordMeaningResponse[]> responseEntity;
        try {
            responseEntity = restTemplate.getForEntity(url, WordMeaningResponse[].class);
        } catch (Exception e) {
            log.error("Error while getting word meaning", e);
            return null;
        }

        if (!responseEntity.getStatusCode().is2xxSuccessful())
            return null;

        WordMeaningResponse[] wordResponses = responseEntity.getBody();
        assert wordResponses != null;
        return new WordMeaningDto()
                .setStatus(responseEntity.getStatusCode().value())
                .setWords(
                        Arrays.stream(wordResponses)
                                .map(wordResponse -> new WordMeaningDto.Word()
                                        .setWord(wordResponse.getWord())
                                        .setPhonetic(wordResponse.getPhonetic())
                                        .setNoun(wordResponse.getMeanings().stream()
                                                .filter(meaning -> meaning.getPartOfSpeech().equals("noun"))
                                                .map(meaning -> new WordMeaningDto.PartOfSpeech()
                                                        .setDefinitions(meaning.getDefinitions().stream()
                                                                .map(WordMeaningResponse.Definitions::getDefinition)
                                                                .collect(Collectors.toList()))
                                                        .setSynonyms(meaning.getSynonyms())
                                                        .setAntonyms(meaning.getAntonyms()))
                                                .findFirst().orElse(null))
                                        .setVerb(wordResponse.getMeanings().stream()
                                                .filter(meaning -> meaning.getPartOfSpeech().equals("verb"))
                                                .map(meaning -> new WordMeaningDto.PartOfSpeech()
                                                        .setDefinitions(meaning.getDefinitions().stream()
                                                                .map(WordMeaningResponse.Definitions::getDefinition)
                                                                .collect(Collectors.toList()))
                                                        .setSynonyms(meaning.getSynonyms())
                                                        .setAntonyms(meaning.getAntonyms()))
                                                .findFirst().orElse(null))
                                )
                                .collect(Collectors.toList())
                );
    }

    public List<FavouriteWordDto> getFavouriteWords(Long userId){
        List<FavouriteWord> favouriteWords = favouriteWordRepository.findAllByUserId(userId);

        return favouriteWords.stream()
                .map(favouriteWord -> new FavouriteWordDto()
                        .setWord(favouriteWord.getWord())
                        .setMeaning(favouriteWord.getMeaning())
                ).collect(Collectors.toList());
    }

    public Long addFavouriteWord(AddFavRequest request){

        User user = userRepository.findUserById(request.getUserId());

        if(user == null)
            throw new RuntimeException("User not found");

        FavouriteWord favouriteWord = new FavouriteWord()
                .setUser(user)
                .setWord(request.getWord())
                .setMeaning(request.getMeaning());
        FavouriteWord saved = favouriteWordRepository.save(favouriteWord);
        return saved.getId();
    }

}
