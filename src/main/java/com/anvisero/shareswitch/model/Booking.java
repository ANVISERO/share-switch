package com.anvisero.shareswitch.model;

import lombok.Builder;
import lombok.Value;

import java.util.Date;

@Value
@Builder(toBuilder = true)
public class Booking {
    Integer id;
    String name;
    String username;
    String ownerUsername;
    Date startDate;
    Date endDate;
    String description;
    String status;
}
