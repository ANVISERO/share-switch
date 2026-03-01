package com.anvisero.shareswitch.service;

import com.anvisero.shareswitch.model.Booking;
import com.anvisero.shareswitch.model.Item;
import com.anvisero.shareswitch.storage.booking.BookingStorage;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Slf4j
@Service
@RequiredArgsConstructor
public class BookingService {
    private final BookingStorage bookingStorage;

    public void addBooking(Booking booking, Integer userId, Integer itemId) {
        bookingStorage.addBooking(booking, userId, itemId);
    }

    public List<Booking> getUsersBookedItems(Integer userId) {
        return bookingStorage.getUsersBookedItems(userId);
    }

    public List<Booking> getAllItemAvailableBookingDates(Integer itemId) {
        return bookingStorage.getAllItemAvailableBookingDates(itemId);
    }

    public List<Booking> getOwnerItemBookingDates(Integer itemId) {
        return bookingStorage.getOwnerItemBookingDates(itemId);
    }

    public void endBooking(Integer bookingId) {
        bookingStorage.endBooking(bookingId);
    }

    public void cancelBooking(Integer bookingId) {
        bookingStorage.cancelBooking(bookingId);
    }

    public void approveBooking(Integer bookingId) {
        bookingStorage.approveBooking(bookingId);
    }

    public void rejectBooking(Integer bookingId) {
        bookingStorage.rejectBooking(bookingId);
    }

    public List<Booking> userItemsBookings(Integer userId) {
        return bookingStorage.userItemsBookings(userId);
    }
}
