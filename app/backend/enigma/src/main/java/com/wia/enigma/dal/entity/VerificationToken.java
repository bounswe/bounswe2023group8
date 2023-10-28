package com.wia.enigma.dal.entity;

import jakarta.persistence.*;
import lombok.*;
import lombok.experimental.FieldDefaults;

import java.sql.Timestamp;

@Entity
@Getter
@Setter
@Builder
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "enigma_verification_token")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class VerificationToken {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    Long id;

    @Column(name = "enigma_user_id")
    Long enigmaUserId;

    @Column(name = "token")
    String token;

    @Column(name = "issued_at")
    Timestamp issuedAt;

    @Column(name = "expires_at")
    Timestamp expiresAt;

    @Column(name = "is_revoked")
    Boolean isRevoked;

    @Column(name = "is_reset_password_token")
    Boolean isResetPasswordToken;
}
