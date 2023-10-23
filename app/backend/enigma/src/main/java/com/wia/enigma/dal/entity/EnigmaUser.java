package com.wia.enigma.dal.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Date;
import java.sql.Timestamp;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Table(name = "enigma_user")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "username", unique = true)
    String username;

    @Column(name = "name", nullable = false )
    String name;

    @Column(name = "email", unique = true)
    String email;

    @Column(name = "password", nullable = false)
    String password;

    @Column(name = "birthday", nullable = false)
    Date birthday;

    @Column(name = "is_private")
    Boolean isPrivate = false;

    @Column(name = "is_deleted")
    Boolean isDeleted = false;

    @Column(name = "create_time")
    Timestamp createTime;

    @Column(name = "delete_time")
    Timestamp deleteTime;
}
