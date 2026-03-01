package com.anvisero.shareswitch.service;

import com.anvisero.shareswitch.model.AuthData;
import com.anvisero.shareswitch.storage.user.UserStorage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class AuthService {
    private final UserStorage userStorage;

    public String signUp(AuthData signUpData) {
        Integer userId = userStorage.addUser(signUpData.getUsername());
        log.info("userId = {}", userId);
        userStorage.addPassword(signUpData.getPassword(), userId);
        return userId.toString();
    }

    public String signIn(AuthData signInData) {
        return userStorage.authUser(signInData).toString();
    }
}
