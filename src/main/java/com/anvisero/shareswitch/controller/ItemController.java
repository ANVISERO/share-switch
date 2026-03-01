package com.anvisero.shareswitch.controller;

import com.anvisero.shareswitch.model.Item;
import com.anvisero.shareswitch.service.ItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/items")
public class ItemController {
    private final ItemService itemService;

    @GetMapping
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Item> getAllItems() {
        log.info("Пришёл запрос на получение доступных для бронирования вещей");
        return itemService.getAllItems();
    }

    @GetMapping("/userItems")
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Item> getUserItems(@RequestParam Integer userId) {
        log.info("Пришёл запрос на получение вещей от пользователя и id = {}", userId);
        return itemService.getUserItems(userId);
    }

    @PostMapping("/item")
    @CrossOrigin(origins = "http://localhost:3000")
    public Item addItem(@RequestParam Integer userId, @RequestBody Item item) {
        log.info("Пришёл запрос на добавление вещи {} от пользователя и id = {}", item, userId);
        return itemService.addItem(userId, item);
    }
}
