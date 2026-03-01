package com.anvisero.shareswitch.exceptions;

import lombok.Getter;

@Getter
public class ErrorResponse {
    private final String error;
    private final String description;

    public ErrorResponse(final String error, final String description) {
        this.error = error;
        this.description = description;
    }
}
