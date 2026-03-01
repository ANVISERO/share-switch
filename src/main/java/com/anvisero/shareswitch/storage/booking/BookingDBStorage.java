package com.anvisero.shareswitch.storage.booking;

import com.anvisero.shareswitch.model.Booking;
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
public class BookingDBStorage implements BookingStorage {
    private final JdbcTemplate jdbcTemplate;

    @Override
    public void addBooking(Booking booking, Integer userId, Integer itemId) {
        SimpleJdbcInsert insert = new SimpleJdbcInsert(jdbcTemplate)
                .withTableName("bookings")
                .usingGeneratedKeyColumns("id");
        int bookingId = insert.executeAndReturnKey(bookingToMap(booking, userId)).intValue();
        log.debug("bookingId = {}", bookingId);
        String sql = "INSERT INTO booked_items (item_id, booking_id) " +
                "VALUES (?, ?)";
        if (jdbcTemplate.update(sql, itemId, bookingId) <= 0) {
            throw new RuntimeException("Ошибка при добавлении пользователя.");
        }
        sql = "UPDATE items " +
                "SET status = ? " +
                "WHERE id = ?";
        if (jdbcTemplate.update(sql, "BOOKED", itemId) <= 0) {
            log.info("Ошибка при обновлении статута вещи.");
            throw new RuntimeException("Ошибка при обновлении статута вещи.");
        }
    }

    @Override
    public List<Booking> getUsersBookedItems(Integer userId) {
        String sql = "SELECT id, name, username, start_date, end_date, description, status " +
                "FROM get_user_bookings(?)";
        return jdbcTemplate.query(sql, mapToBooking(), userId);
    }

    @Override
    public List<Booking> getAllItemAvailableBookingDates(Integer itemId) {
        String sql = "SELECT start_date, end_date " +
                "FROM get_booked_dates(?)";
        return jdbcTemplate.query(sql, (rs, rowNum) -> Booking.builder()
                .startDate(rs.getDate("start_date"))
                .endDate(rs.getDate("end_date"))
                .build(), itemId);
    }

    @Override
    public List<Booking> getOwnerItemBookingDates(Integer itemId) {
        String sql = "SELECT id, start_date, end_date, status " +
                "FROM get_owner_booked_dates(?)";
        return jdbcTemplate.query(sql, (rs, rowNum) -> Booking.builder()
                .id(rs.getInt("id"))
                .startDate(rs.getDate("start_date"))
                .endDate(rs.getDate("end_date"))
                .status(rs.getString("status"))
                .build(), itemId);
    }

    @Override
    public void endBooking(Integer bookingId) {
        String sql = "UPDATE bookings " +
                "SET status = ? " +
                "WHERE id = ?";
        if (jdbcTemplate.update(sql, "DONE", bookingId) <= 0) {
            log.info("Ошибка завершении бронирования.");
            throw new RuntimeException("Ошибка при завершении бронирования.");
        }
    }

    @Override
    public void cancelBooking(Integer bookingId) {
        String sql = "UPDATE bookings " +
                "SET status = ? " +
                "WHERE id = ?";
        if (jdbcTemplate.update(sql, "CANCELLED", bookingId) <= 0) {
            log.info("Ошибка отмены бронирования.");
            throw new RuntimeException("Ошибка при отмене бронирования.");
        }
    }

    @Override
    public void approveBooking(Integer bookingId) {
        String sql = "UPDATE bookings " +
                "SET status = ? " +
                "WHERE id = ?";
        if (jdbcTemplate.update(sql, "APPROVED", bookingId) <= 0) {
            log.info("Ошибка одобрения бронирования.");
            throw new RuntimeException("Ошибка при одобрении бронирования.");
        }
    }

    @Override
    public void rejectBooking(Integer bookingId) {
        String sql = "UPDATE bookings " +
                "SET status = ? " +
                "WHERE id = ?";
        if (jdbcTemplate.update(sql, "REJECTED", bookingId) <= 0) {
            log.info("Ошибка отклонения бронирования.");
            throw new RuntimeException("Ошибка при отклонении бронирования.");
        }
    }

    @Override
    public List<Booking> userItemsBookings(Integer userId) {
        String sql = "SELECT id, name, username, start_date, end_date, status, description " +
                "FROM get_owner_items_books(?)";
        return jdbcTemplate.query(sql, mapToBooking(), userId);
    }

    private static Map<String, Object> bookingToMap(Booking booking, Integer userId) {
        log.info("bookingToMap");
        return Map.of(
                "user_id", userId,
                "start_date", booking.getStartDate(),
                "end_date", booking.getEndDate(),
                "status", booking.getStatus(),
                "description", booking.getDescription());
    }

    private RowMapper<Booking> mapToBooking() {
        log.info("mapToBooking");
        return (rs, rowNum) -> Booking.builder()
                .id(rs.getInt("id"))
                .name(rs.getString("name"))
                .username(rs.getString("username"))
                .startDate(rs.getDate("start_date"))
                .endDate(rs.getDate("end_date"))
                .description(rs.getString("description"))
                .status(rs.getString("status"))
                .build();
    }
}
