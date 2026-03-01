package com.anvisero.shareswitch.controller;

import com.anvisero.shareswitch.model.User;
import com.anvisero.shareswitch.service.UserService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;


@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/users")
public class UserController {
    private final UserService userService;

    @GetMapping("/user")
    @CrossOrigin(origins = "http://localhost:3000")
    public User getUserById(@RequestParam Integer userId) {
        log.info("Пришёл запрос на получение информации о пользователе с id = {}", userId);
        return userService.getUserById(userId);
    }
}
