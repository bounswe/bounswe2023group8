package com.bounswe.group8.controller;


import com.bounswe.group8.payload.request.UserCreateRequest;
import com.bounswe.group8.payload.dto.UserDto;
import com.bounswe.group8.service.UserService;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

@RestController
@RequestMapping("/api/user")
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class UserController {

    final UserService userService;

    /*
     *  WARN: This is a dummy endpoint. It is not used in the project. Just for test purposes.
     */
    @GetMapping("/all")
    public ResponseEntity<List<UserDto>> getAllUsers() {
        return ResponseEntity.ok(
                userService.getAll()
        );
    }

    /**
     * U1: Gets users with pagination.
     *
     * @param page      Page number. Starts at 0. Is the only required parameter.
     * @param size      Number of elements per page. Default value is 10.
     * @param sortBy    Field to sort by. Default value is "id".
     * @param desc      Sort direction. Default value is "false".
     * @return          List of users in the page
     */
    @GetMapping
    public ResponseEntity<List<UserDto>> getUserPage(
            @RequestParam(defaultValue = "0") Integer page,
            @RequestParam(defaultValue = "10", required = false) Integer size,
            @RequestParam(defaultValue = "id", required = false) String sortBy,
            @RequestParam(defaultValue = "false", required = false) Boolean desc) {

        List<UserDto> userPage = userService.getUserPage(page, size, sortBy, desc);

        if (userPage.isEmpty())
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok().body(userPage);
    }

    /**
     * U2-1: Get a user by id.
     *
     * @param id    User id
     * @return      UserDto
     */
    @GetMapping("/{id}")
    public ResponseEntity<UserDto> getUserById(@PathVariable Long id) {

        UserDto userDto = userService.getUserById(id);

        if (userDto == null)
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok().body(userDto);
    }

    /**
     * U2-2: Get a user by username.
     *
     * @param username  User username
     * @return          UserDto
     */
    @GetMapping("/username")
    public ResponseEntity<UserDto> getUserByUsername(@RequestParam String username) {

        UserDto userDto = userService.getUserByUsername(username);

        if (userDto == null)
            return ResponseEntity.noContent().build();

        return ResponseEntity.ok().body(userDto);
    }

    /**
     * U3: Create a user.
     * @param userCreateRequest    create request
     * @return                     UserDto - created user
     */
    @PostMapping
    public ResponseEntity<UserDto> createUser(
            @RequestBody UserCreateRequest userCreateRequest) {

        Long userId = userService.createUser(userCreateRequest);

        if (userId == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.created(
                ServletUriComponentsBuilder
                        .fromCurrentRequest()
                        .path("/{id}")
                        .buildAndExpand(userId)
                        .toUri()
        ).build();
    }

    /**
     * U4: Update a user.
     *
     * @param id        id of the user to be updated.
     * @param username  new username
     * @param password  new password
     * @return          UserDto - updated user
     */
    @PutMapping("/{id}")
    public ResponseEntity<UserDto> updateUser(
            @PathVariable Long id,
            @RequestParam String username,
            @RequestParam String password) {

        UserDto userDto = userService.updateUserById(id, username, password);

        if (userDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(userDto);
    }

    /**
     * U5: Delete an user.
     *
     * @param id    id of the user to be deleted.
     * @return      UserDto - deleted user
     */
    @DeleteMapping("/{id}")
    public ResponseEntity<UserDto> deleteUser(@PathVariable Long id) {

        UserDto userDto = userService.deleteUserById(id);

        if (userDto == null)
            return ResponseEntity.badRequest().build();

        return ResponseEntity.ok().body(userDto);
    }

}
