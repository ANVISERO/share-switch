package com.anvisero.shareswitch.model;

import lombok.Builder;
import lombok.Value;

@Value
@Builder(toBuilder = true)
public class User {
    String username;
    String email;
    String phoneNumber;
    String sex;
}
