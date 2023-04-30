package com.bounswe.group8.model;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.Accessors;
import lombok.experimental.FieldDefaults;

import java.util.HashSet;
import java.util.Set;

/* jakarta persistence annotation. Specifies that the class is an entity/model. */
@Entity
/* sets the name of the table to be created in the database. */
@Table(name = "users")
/* lombok annotation. Creates getters, setters for all fields plus equals, hash and toString methods. */
@Data
/* lombok annotation. Creates builder pattern for class. */
@Builder
/* lombok annotation. Allows chain access to class methods. e.g. user.setId(id).setUsername(username).set ... */
@Accessors(chain = true)
/* lombok annotation. Creates a constructor with no arguments. */
@NoArgsConstructor
/* lombok annotation. Creates a constructor with all possible arguments. */
@AllArgsConstructor
/* lombok annotation. Sets the default access level to private. */
@FieldDefaults(level = lombok.AccessLevel.PRIVATE)
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id", nullable = false, updatable = false, unique = true)
    Long id;

    @Column(name = "username", nullable = false, unique = true)
    String username;

    @ToString.Exclude
    @Column(name = "password", nullable = false)
    String password;

    @ToString.Exclude
    @EqualsAndHashCode.Exclude
    @OneToMany(mappedBy = "user", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    Set<Post> posts = new HashSet<>();

}
