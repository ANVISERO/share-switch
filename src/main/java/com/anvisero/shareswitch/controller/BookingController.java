package com.anvisero.shareswitch.controller;

import com.anvisero.shareswitch.model.Booking;
import com.anvisero.shareswitch.model.Item;
import com.anvisero.shareswitch.service.BookingService;
import com.anvisero.shareswitch.service.ItemService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;

import java.awt.print.Book;
import java.util.List;

@Slf4j
@RequiredArgsConstructor
@RestController
@RequestMapping("/booking")
public class BookingController {
    private final BookingService bookingService;

    @PostMapping("/book")
    @CrossOrigin(origins = "http://localhost:3000")
    public void addBooking(@RequestParam Integer userId, @RequestParam Integer itemId, @RequestBody Booking booking) {
        log.info("Пришёл запрос на бронирование {} от пользователя и id = {}, идентификатор вещи {}",
                booking, userId, itemId);
        bookingService.addBooking(booking, userId, itemId);
    }

    @GetMapping("/items")
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Booking> getAllItems(@RequestParam Integer userId) {
        log.info("Пришёл запрос на получение забронированных вещей пользователя");
        return bookingService.getUsersBookedItems(userId);
    }

    @GetMapping("/bookings")
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Booking> getAllItemAvailableBookingDates(@RequestParam Integer itemId) {
        log.info("Пришёл запрос на получение дат бронирования вещи пользователями");
        return bookingService.getAllItemAvailableBookingDates(itemId);
    }

    @GetMapping("/ownerBookings")
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Booking> getOwnerItemBookingDates(@RequestParam Integer itemId) {
        log.info("Пришёл запрос на получение всех дат бронирования вещи пользователями");
        return bookingService.getOwnerItemBookingDates(itemId);
    }

    @PostMapping("/endBooking")
    @CrossOrigin(origins = "http://localhost:3000")
    public void endBooking(@RequestParam Integer bookingId) {
        log.info("Пришёл запрос на завершение бронирования");
        bookingService.endBooking(bookingId);
    }

    @PostMapping("/cancelBooking")
    @CrossOrigin(origins = "http://localhost:3000")
    public void cancelBooking(@RequestParam Integer bookingId) {
        log.info("Пришёл запрос на отмену бронирования");
        bookingService.cancelBooking(bookingId);
    }

    @PostMapping("/approveBooking")
    @CrossOrigin(origins = "http://localhost:3000")
    public void approveBooking(@RequestParam Integer bookingId) {
        log.info("Пришёл запрос на подтверждение бронирования");
        bookingService.approveBooking(bookingId);
    }

    @PostMapping("/rejectBooking")
    @CrossOrigin(origins = "http://localhost:3000")
    public void rejectBooking(@RequestParam Integer bookingId) {
        log.info("Пришёл запрос на отклонение бронирования");
        bookingService.rejectBooking(bookingId);
    }

    @GetMapping("/history")
    @CrossOrigin(origins = "http://localhost:3000")
    public List<Booking> userItemsBookings(@RequestParam Integer userId) {
        log.info("Пришёл запрос на получение всех бронирований товаров пользователя (история)");
        return bookingService.userItemsBookings(userId);
    }
}
