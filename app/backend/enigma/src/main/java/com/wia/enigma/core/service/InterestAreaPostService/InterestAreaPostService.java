package com.wia.enigma.core.service.InterestAreaPostService;

import com.wia.enigma.core.data.dto.PostDto;
import com.wia.enigma.dal.entity.InterestAreaPost;

import java.util.List;

public interface InterestAreaPostService {

    void deleteAllByInterestAreaId(Long interestAreaId);

    List<InterestAreaPost> getPostsByInterestAreaId(Long interestAreaId);
}
