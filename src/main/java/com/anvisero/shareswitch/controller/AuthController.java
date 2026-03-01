package com.anvisero.shareswitch.controller;

import com.anvisero.shareswitch.model.AuthData;
import com.anvisero.shareswitch.service.AuthService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/auth")
public class AuthController {
    private final AuthService authService;

    @PostMapping("/signUp")
    @CrossOrigin(origins = "http://localhost:3000")
    public String signUp(@RequestBody AuthData signUpData) {
        log.info("Пришёл запрос на регистрацию {}", signUpData);
        return authService.signUp(signUpData);
    }

    @PostMapping("/signIn")
    @CrossOrigin(origins = "http://localhost:3000")
    public String signIn(@RequestBody AuthData signInData) {
        log.info("Пришёл запрос на аутентификацию {}", signInData);
        return authService.signIn(signInData);
    }

}
