package com.anvisero.shareswitch.storage.item;

import com.anvisero.shareswitch.model.Item;

import java.util.List;

public interface ItemStorage {
    List<Item> getAllItems();

    List<Item> getUserItems(Integer userId);

    Item addItem(Integer userId, Item item);
}
