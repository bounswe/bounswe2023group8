package com.wia.enigma.dto;

import com.wia.enigma.dal.entity.EnigmaUser;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.util.Date;

@Data
@NoArgsConstructor
public class EnigmaUserDTO {

    private Long id;
    private String username;
    private String name;
    private String email;
    private Date birthday;
    private Boolean isPrivate;
    private Timestamp createdTime;

    public EnigmaUserDTO(EnigmaUser user) {
        this.id = user.getId();
        this.username = user.getUsername();
        this.name = user.getName();
        this.email = user.getEmail();
        this.birthday = user.getBirthday();
        this.isPrivate = user.getIsPrivate();
        this.createdTime = user.getCreateTime();
    }
}
