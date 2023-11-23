package com.wia.enigma.core.service.InterestAreaPostService;

import com.wia.enigma.dal.entity.InterestAreaPost;
import com.wia.enigma.dal.repository.InterestAreaPostRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class InterestAreaPostServiceImpl implements InterestAreaPostService {

    final InterestAreaPostRepository interestAreaPostRepository;

    @Override
    public void deleteAllByInterestAreaId(Long interestAreaId) {

        interestAreaPostRepository.deleteAllByInterestAreaId(interestAreaId);
    }

    @Override
    public List<InterestAreaPost> getPostsByInterestAreaId(Long interestAreaId) {

        return interestAreaPostRepository.findByInterestAreaId(interestAreaId);
    }
}
