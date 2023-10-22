package com.wia.enigma.service;

import com.wia.enigma.dto.UserDTO;
import com.wia.enigma.exceptions.UserNotFoundException;
import com.wia.enigma.model.User;
import com.wia.enigma.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserServiceImpl implements UserService {

    private final UserRepository userRepository;

    @Override
    public UserDTO getUserById(Long id) throws UserNotFoundException {
        User user = userRepository.findById(id)
                .orElseThrow(() -> new UserNotFoundException("User not found! (id:" + id + ")"));
        return new UserDTO(user);
    }

}
