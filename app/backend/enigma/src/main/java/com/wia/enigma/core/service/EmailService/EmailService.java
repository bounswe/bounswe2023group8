package com.wia.enigma.core.service.EmailService;

public interface EmailService {

    void sendVerificationEmail(String email, String token);

    void sendPasswordResetEmail(String email, String token);
}
