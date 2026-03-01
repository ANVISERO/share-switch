package com.anvisero.shareswitch.exceptions.handlers;

import com.anvisero.shareswitch.exceptions.*;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestControllerAdvice;

@Slf4j
@RestControllerAdvice
public class ErrorHandler {

    @ExceptionHandler
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ErrorResponse handleValidationException(final ValidationException exception) {
        log.warn("Ошибка валидации. Были переданы некорректные данные.");
        return new ErrorResponse("Ошибка валидации", exception.getMessage());
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public ErrorResponse handleNotFoundException(final NotFoundException exception) {
        log.warn("Искомый объект не найден.");
        return new ErrorResponse("Искомый объект не найден", exception.getMessage());
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.CONFLICT)
    public ErrorResponse handleAlreadyExistsException(final AlreadyExistsException exception) {
        log.warn("Искомый объект уже существует.");
        return new ErrorResponse("Искомый объект уже существует", exception.getMessage());
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public ErrorResponse handleIncorrectPasswordException(final IncorrectPasswordException exception) {
        log.warn("Введён неверный пароль.");
        return new ErrorResponse("Введён неверный пароль", exception.getMessage());
    }

    @ExceptionHandler
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public ErrorResponse handleRuntimeException(final RuntimeException exception) {
        log.warn("Ошибка во время выполнения запроса.");
        return new ErrorResponse("Ошибка во время выполнения запроса", exception.getMessage());
    }
}
