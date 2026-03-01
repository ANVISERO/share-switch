package com.anvisero.shareswitch.storage.user;


import com.anvisero.shareswitch.exceptions.AlreadyExistsException;
import com.anvisero.shareswitch.exceptions.IncorrectPasswordException;
import com.anvisero.shareswitch.exceptions.NotFoundException;
import com.anvisero.shareswitch.model.AuthData;
import com.anvisero.shareswitch.model.Item;
import com.anvisero.shareswitch.model.User;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;

import java.util.Map;

@Slf4j
@RequiredArgsConstructor
@Repository
public class UserDBStorage implements UserStorage {
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void addPassword(String password, Integer userId) {
        String sql = "INSERT INTO passwords (user_id, password)" +
                "VALUES (?, ?)";
        if (jdbcTemplate.update(sql, userId, password) <= 0) {
            throw new RuntimeException("Ошибка при добавлении пользователя.");
        }
    }

    @Override
    public Integer addUser(String username) {
        if (findUserByUsername(username)) {
            throw new AlreadyExistsException("Пользователь с таким именем уже существует.");
        }
        SimpleJdbcInsert insert = new SimpleJdbcInsert(jdbcTemplate)
                .withTableName("users")
                .usingGeneratedKeyColumns("id");
        return insert.executeAndReturnKey(Map.of("username", username)).intValue();
    }

    @Override
    public Integer authUser(AuthData signInData) {
        if (!findUserByUsername(signInData.getUsername())) {
            throw new NotFoundException("Пользователь с таким именем не существует.");
        }
        String sql = "SELECT u.id " +
                "FROM users AS u " +
                "JOIN passwords AS p ON u.id = p.user_id " +
                "WHERE u.username = ? AND p.password = ?";
        Integer userId = jdbcTemplate.queryForObject(sql, (rs, rowNum) -> rs.getInt("id"),
                signInData.getUsername(), signInData.getPassword());
        if (userId == null) {
            throw new IncorrectPasswordException("Неверный пароль");
        }
        log.info("Пароль проверен, id = {}; {}", userId, signInData);
        return userId;
    }

    @Override
    public User getUserById(Integer userId) {
        String sql = "SELECT username, email, phone_number, sex " +
                "FROM users " +
                "WHERE id = ?";
        return jdbcTemplate.queryForObject(sql, mapToUser(), userId);
    }

    private boolean findUserByUsername(String username) {
        String sql = "SELECT id FROM users WHERE username = ?";
        SqlRowSet filmRaws = jdbcTemplate.queryForRowSet(sql, username);
        return filmRaws.next();
    }

    private RowMapper<User> mapToUser() {
        log.info("mapToUser");
        return (rs, rowNum) -> User.builder()
                .username(rs.getString("username"))
                .email(rs.getString("email"))
                .phoneNumber(rs.getString("phone_number"))
                .sex(rs.getString("sex"))
                .build();
    }

}
