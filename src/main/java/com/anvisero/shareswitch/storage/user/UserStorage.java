package com.anvisero.shareswitch.storage.user;


import com.anvisero.shareswitch.model.AuthData;
import com.anvisero.shareswitch.model.User;

public interface UserStorage {
    void addPassword(String password, Integer userId);

    Integer addUser(String username);

    Integer authUser(AuthData SignInData);

    User getUserById(Integer userId);
}
