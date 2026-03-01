package com.anvisero.shareswitch.storage.item;

import com.anvisero.shareswitch.model.Item;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Slf4j
@Repository
@RequiredArgsConstructor
public class ItemDBStorage implements ItemStorage {
    private final JdbcTemplate jdbcTemplate;

    @Override
    public List<Item> getAllItems() {
        String sql = "SELECT id, name, description, status " +
                "FROM get_all_items()";
        return jdbcTemplate.query(sql, mapToItem());
    }

    @Override
    public List<Item> getUserItems(Integer userId) {
        String sql = "SELECT id, name, description, status " +
                "FROM items " +
                "WHERE owner_id = ?";
        return jdbcTemplate.query(sql, mapToItem(), userId);
    }

    @Override
    public Item addItem(Integer userId, Item item) {
        SimpleJdbcInsert insert = new SimpleJdbcInsert(jdbcTemplate)
                .withTableName("items")
                .usingGeneratedKeyColumns("id");
        int id = insert.executeAndReturnKey(itemToMap(item, userId)).intValue();
        log.debug("id = {}", id);
        return item.toBuilder().id(id).build();
    }

    private RowMapper<Item> mapToItem() {
        log.info("mapToItem");
        return (rs, rowNum) -> Item.builder()
                .id(rs.getInt("id"))
                .name(rs.getString("name"))
                .description(rs.getString("description"))
                .status(rs.getString("status"))
                .build();
    }

    private static Map<String, Object> itemToMap(Item item, Integer userId) {
        return Map.of(
                "name", item.getName(),
                "description", item.getDescription(),
                "owner_id", userId,
                "status", item.getStatus());
    }
}
