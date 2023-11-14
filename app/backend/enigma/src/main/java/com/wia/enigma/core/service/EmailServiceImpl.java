package com.wia.enigma.core.service;

import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EmailServiceImpl implements EmailService {

    @Value("${client.url}")
    String clientURL;

    static final String FROM = "no-reply@bunchup.com.tr";

    final JavaMailSender mailSender;

    /**
     * Sends a verification email to the user.
     *
     * @param email     recipient email
     * @param token     token
     */
    @Override
    public void sendVerificationEmail(String email, String token) {

        String subject = "Registration Confirmation";
        String confirmationUrl = clientURL+ "/registration-confirm?token=" + token;
        String text = "Please click the below link to activate your account: " + confirmationUrl;

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(FROM);
        message.setTo(email);
        message.setSubject(subject);
        message.setText(text);

        mailSender.send(message);
    }


    /**
     * Sends a password reset email to the user.
     *
     * @param email     recipient email
     * @param token     token
     */
    @Override
    public void sendPasswordResetEmail(String email, String token) {

        String subject = "Password Reset";
        String confirmationUrl = clientURL+"/reset-password?token=" + token;
        String text = "Please click the below link to reset your password: " + confirmationUrl;

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(FROM);
        message.setTo(email);
        message.setSubject(subject);
        message.setText(text);

        mailSender.send(message);
    }
}
