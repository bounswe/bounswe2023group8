package com.wia.enigma.dto;

import com.wia.enigma.model.User;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
@NoArgsConstructor
public class UserDTO {

    private Long id;
    private String username;
    private String name;
    private String email;
    private LocalDate birthday;
    private Boolean isPrivate;
    private LocalDateTime createdAt;

    public UserDTO(User user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.name = user.getName();
        this.email = user.getEmail();
        this.birthday = user.getBirthday();
        this.isPrivate = user.getIsPrivate();
        this.createdAt = user.getCreatedAt();
    }
}
