package com.bounswe.group8.service;

import com.bounswe.group8.exception.custom.ResourceNotFoundException;
import com.bounswe.group8.mapper.UserMapper;
import com.bounswe.group8.model.User;
import com.bounswe.group8.payload.UserCreateRequest;
import com.bounswe.group8.payload.dto.UserDto;
import com.bounswe.group8.repository.UserRepository;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/* logger. can be used with log.info(), log.error(), log.debug() etc. */
@Slf4j // Simple Logging Facade for Java
/* service annotation. used to define a service bean. */
@Service
/* lombok annotation. generates a constructor with required (final) arguments. */
@RequiredArgsConstructor
/* lombok annotation. sets the default access level to private. */
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserService {

    final UserRepository userRepository; // dependency injection

    /**
     * Get all users. Should not be used in production due to performance issues.
     *
     * @return List of all users
     */
    public List<UserDto> getAll() {

        List<User> users = userRepository.findAll();

        return users.stream()
                .map(UserMapper::userToUserDto)
                .collect(Collectors.toList());
    }


    /**
     * Get user page. Constraints and defaults are set in the controller.
     *
     * @param page      Page number
     * @param size      Page size
     * @param sortBy    Sort by field
     * @param desc      Sort direction
     * @return          List of users in the page
     */
    public List<UserDto> getUserPage(Integer page,
                                     Integer size,
                                     String sortBy,
                                     Boolean desc) {
        Sort sort;
        try {
            if (desc)
                sort = Sort.by(sortBy).descending();
            else
                sort = Sort.by(sortBy).ascending();
        } catch (Exception e) {
            sort = Sort.by("id");
        }

        Pageable pageable = PageRequest.of(page, size, sort);
        Page<User> userPage;

        try {
            userPage = userRepository.findAll(pageable);
        } catch (Exception e) {
            log.error(e.getMessage(), e);
            userPage = Page.empty();
        }

        return userPage.stream()
                .map(UserMapper::userToUserDto)
                .collect(Collectors.toList());
    }

    /**
     * Get user by id.
     *
     * @param id    User id
     * @return      UserDto
     */
    public UserDto getUserById(Long id) {

        User user = userRepository.findUserById(id);

        if (user == null)
            throw new ResourceNotFoundException("user", "id", id.toString());

        return UserMapper.userToUserDto(user);
    }

    /**
     * Get user by username.
     *
     * @param username  User username
     * @return          UserDto
     */
    public UserDto getUserByUsername(String username) {

        User user = userRepository.findUserByUsername(username);

        if (user == null)
            throw new ResourceNotFoundException("user", "username", username);

        return UserMapper.userToUserDto(user);
    }

    /**
     * Update user by id. Username and password can be updated.
     *
     * @param id        User id
     * @param username  New username
     * @param password  New password
     * @return          UserDto - updated user
     */
    public UserDto updateUserById(Long id,
                                  String username,
                                  String password) {

        User user = userRepository.findUserById(id);

        if (user == null)
            throw new ResourceNotFoundException("user", "id", id.toString());

        boolean updated = false;

        if (username != null) {
            if (userRepository.existsByUsername(username))
                throw new IllegalArgumentException("Username already exists");

            if (username.equals(user.getUsername()))
                throw new IllegalArgumentException("Username is the same");

            user.setUsername(username);
            updated = true;
        }

        if (password != null) {
            user.setPassword(password);
            updated = true;
        }

        if (updated)
            userRepository.save(user);

        return UserMapper.userToUserDto(user);
    }

    /**
     * Create user.
     *
     * @param request   UserCreateRequest
     * @return          User id - created user
     */
    public Long createUser(UserCreateRequest request) {

        User user = User.builder()
                .username(request.getUsername())
                .password(request.getPassword())
                .build();

        User saved  = userRepository.save(user);

        return saved.getId();
    }

    /**
     * Delete user by id.
     *
     * @param id    User id
     * @return      UserDto - deleted user
     */
    public UserDto deleteUserById(Long id) {

        User user = userRepository.findUserById(id);

        if (user == null)
            throw new ResourceNotFoundException("user", "id", id.toString());

        userRepository.delete(user);

        return UserMapper.userToUserDto(user);
    }

}
