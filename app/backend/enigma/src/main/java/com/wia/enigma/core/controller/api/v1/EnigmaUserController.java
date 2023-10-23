package com.wia.enigma.core.controller.api.v1;

import com.wia.enigma.core.service.EnigmaUserServiceImpl;
import lombok.AccessLevel;
import lombok.RequiredArgsConstructor;
import lombok.experimental.FieldDefaults;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequiredArgsConstructor
@RequestMapping("/api/v1/user")
@FieldDefaults(level = AccessLevel.PRIVATE)
public class EnigmaUserController {

}
