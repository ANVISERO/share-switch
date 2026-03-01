package com.anvisero.shareswitch.model;

import lombok.Builder;
import lombok.Value;

@Value
@Builder(toBuilder = true)
public class Item {
    Integer id;
    String name;
    String description;
    String status;
}
