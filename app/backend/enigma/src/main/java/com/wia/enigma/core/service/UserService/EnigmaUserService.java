package com.wia.enigma.core.service.UserService;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import com.wia.enigma.core.data.dto.InterestAreaSimpleDto;
import com.wia.enigma.core.data.response.LoginResponse;
import com.wia.enigma.core.data.response.RegisterResponse;
import com.wia.enigma.core.data.response.VerificationResponse;

import java.util.List;

public interface EnigmaUserService {

    RegisterResponse registerEnigmaUser(String username, String name, String email, String password, String birthday);

    LoginResponse loginEnigmaUser(String username, String password);

    void logoutEnigmaUser(String jwt);

    VerificationResponse verifyEnigmaUser(String token);

    void forgotPassword(String email);

    void resetPassword(String token, String newPassword1, String newPassword2);

    void followUser(Long userId, Long followId);

    void unfollowUser(Long userId, Long followId);

    List<EnigmaUserDto> getFollowers(Long userId, Long followedId);

    List<EnigmaUserDto>  getFollowings(Long userId, Long followerId);

    List<InterestAreaSimpleDto> getFollowingInterestAreas(Long userId, Long followerId);

    EnigmaUserDto getVerifiedUser(Long id);

    List<EnigmaUserDto> search(Long userId, String searchKey);
}
