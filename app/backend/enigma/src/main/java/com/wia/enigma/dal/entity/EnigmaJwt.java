package com.wia.enigma.dal.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "enigma_jwt")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaJwt {

    @Id
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "issued_at")
    Timestamp issuedAt;

    @Column(name = "expires_at")
    Timestamp expiresAt;

    @Column(name = "revoked_at")
    Timestamp revokedAt;

    @Column(name = "is_refresh_token")
    Boolean isRefreshToken;
}
