package com.wia.enigma.dal.entity;

import com.wia.enigma.core.data.dto.EnigmaUserDto;
import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Date;
import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "enigma_user")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "username")
    String username;

    @Column(name = "name")
    String name;

    @Column(name = "email")
    String email;

    @Column(name = "password")
    String password;

    @Column(name = "birthday")
    Date birthday;

    @Column(name = "audience_type")
    String audienceType;

    @Column(name = "is_verified")
    Boolean isVerified = false;

    @Column(name = "is_deleted")
    Boolean isDeleted = false;

    @Column(name = "create_time")
    Timestamp createTime;

    @Column(name = "delete_time")
    Timestamp deleteTime;


    public EnigmaUserDto mapToEnigmaUserDto() {
        return EnigmaUserDto.builder()
                .id(this.getId())
                .username(this.getUsername())
                .name(this.getName())
                .email(this.getEmail())
                .birthday(this.getBirthday())
                .createTime(this.getCreateTime())
                .build();
    }
}
