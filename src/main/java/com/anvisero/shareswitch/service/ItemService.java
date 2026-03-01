package com.anvisero.shareswitch.service;

import com.anvisero.shareswitch.model.Booking;
import com.anvisero.shareswitch.model.Item;
import com.anvisero.shareswitch.storage.item.ItemStorage;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ItemService {
    private final ItemStorage itemStorage;
    public List<Item> getAllItems() {
        return itemStorage.getAllItems();
    }

    public List<Item> getUserItems(Integer userId) {
        return itemStorage.getUserItems(userId);
    }

    public Item addItem(Integer userId, Item item) {
        return itemStorage.addItem(userId, item);
    }
}
