package com.wia.enigma.core.service;

import com.wia.enigma.dal.entity.EnigmaUser;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


@Slf4j
@Service
@RequiredArgsConstructor
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EmailService {

    @Value("${client.url}")
    String clientURL;


    final JavaMailSender mailSender;



    public void sendVerificationEmail(String email, String token) {

        String recipientAddress = email;
        String subject = "Registration Confirmation";
        String confirmationUrl = clientURL+ "/registration-confirm?token=" + token;
        String text = "Please click the below link to activate your account: " + confirmationUrl;

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("no-reply@bunchup.com.tr");  // Change this to your desired 'From' address
        message.setTo(recipientAddress);
        message.setSubject(subject);
        message.setText(text);

        mailSender.send(message);
    }

    public void sendPasswordResetEmail(String email, String token) {

        String recipientAddress = email;
        String subject = "Password Reset";
        String confirmationUrl = clientURL+"/reset-password?token=" + token;
        String text = "Please click the below link to reset your password: " + confirmationUrl;

        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom("no-reply@bunchup.com.tr");  // Change this to your desired 'From' address
        message.setTo(recipientAddress);
        message.setSubject(subject);
        message.setText(text);

        mailSender.send(message);
    }
}



