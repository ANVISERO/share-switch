package com.anvisero.shareswitch.service;

import com.anvisero.shareswitch.model.User;
import com.anvisero.shareswitch.storage.user.UserStorage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class UserService {
    private final UserStorage userStorage;
    public User getUserById(Integer userId) {
        return userStorage.getUserById(userId);
    }
}
