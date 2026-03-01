package com.anvisero.shareswitch.storage.booking;

import com.anvisero.shareswitch.model.Booking;
import com.anvisero.shareswitch.model.Item;

import java.util.List;

public interface BookingStorage {
    void addBooking(Booking booking, Integer userId, Integer itemId);

    List<Booking> getUsersBookedItems(Integer userId);

    List<Booking> getAllItemAvailableBookingDates(Integer itemId);

    List<Booking> getOwnerItemBookingDates(Integer itemId);

    void endBooking(Integer bookingId);

    void cancelBooking(Integer bookingId);

    void approveBooking(Integer bookingId);

    void rejectBooking(Integer bookingId);

    List<Booking> userItemsBookings(Integer userId);
}
