package com.ecotravel.dao;

import com.ecotravel.model.Booking;
import com.ecotravel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BookingDao {

    public boolean createBooking(Booking b) {
        String sql = "INSERT INTO bookings (user_id, destination_id, hotel_id, transport_id, contact_name, contact_mobile, total_cost, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            if (b.getUserId() != 0) {
                ps.setInt(1, b.getUserId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            
            ps.setInt(2, b.getDestinationId());
            ps.setInt(3, b.getHotelId());
            ps.setInt(4, b.getTransportId());
            ps.setString(5, b.getContactName());
            ps.setString(6, b.getContactMobile());
            ps.setDouble(7, b.getTotalCost());
            ps.setString(8, b.getStatus() != null ? b.getStatus() : "Confirmed");
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, d.name as dest_name, h.name as hotel_name, t.type as trans_type " +
                     "FROM bookings b " +
                     "LEFT JOIN destinations d ON b.destination_id = d.id " +
                     "LEFT JOIN hotels h ON b.hotel_id = h.id " +
                     "LEFT JOIN transport t ON b.transport_id = t.id " +
                     "WHERE b.user_id = ? ORDER BY b.booking_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(extractBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Booking> getAllBookings() {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, d.name as dest_name, h.name as hotel_name, t.type as trans_type " +
                     "FROM bookings b " +
                     "LEFT JOIN destinations d ON b.destination_id = d.id " +
                     "LEFT JOIN hotels h ON b.hotel_id = h.id " +
                     "LEFT JOIN transport t ON b.transport_id = t.id " +
                     "ORDER BY b.booking_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(extractBooking(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Booking extractBooking(ResultSet rs) throws SQLException {
        Booking b = new Booking();
        b.setId(rs.getInt("id"));
        b.setUserId(rs.getInt("user_id"));
        b.setDestinationId(rs.getInt("destination_id"));
        b.setHotelId(rs.getInt("hotel_id"));
        b.setTransportId(rs.getInt("transport_id"));
        b.setContactName(rs.getString("contact_name"));
        b.setContactMobile(rs.getString("contact_mobile"));
        b.setTotalCost(rs.getDouble("total_cost"));
        b.setStatus(rs.getString("status"));
        b.setBookingDate(rs.getTimestamp("booking_date"));
        
        b.setDestinationName(rs.getString("dest_name"));
        b.setHotelName(rs.getString("hotel_name"));
        b.setTransportType(rs.getString("trans_type"));
        return b;
    }
}
