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

    public int createBooking(Booking b) {
        String sql = "INSERT INTO bookings (user_id, destination_id, hotel_id, contact_name, contact_mobile, email, total_cost, status, booking_type, check_in, check_out, room_type, adults, children, rooms) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, java.sql.Statement.RETURN_GENERATED_KEYS)) {
            
            if (b.getUserId() != 0) {
                ps.setInt(1, b.getUserId());
            } else {
                ps.setNull(1, java.sql.Types.INTEGER);
            }
            
            if (b.getDestinationId() != 0) {
                ps.setInt(2, b.getDestinationId());
            } else {
                ps.setNull(2, java.sql.Types.INTEGER);
            }
            
            if (b.getHotelId() != 0) {
                ps.setInt(3, b.getHotelId());
            } else {
                ps.setNull(3, java.sql.Types.INTEGER);
            }
            
            ps.setString(4, b.getContactName());
            ps.setString(5, b.getContactMobile());
            ps.setString(6, b.getEmail());
            ps.setDouble(7, b.getTotalCost());
            ps.setString(8, b.getStatus() != null ? b.getStatus() : "Pending");
            ps.setString(9, b.getBookingType() != null ? b.getBookingType() : "destination");
            ps.setString(10, b.getCheckIn());
            ps.setString(11, b.getCheckOut());
            ps.setString(12, b.getRoomType());
            ps.setInt(13, b.getAdults());
            ps.setInt(14, b.getChildren());
            ps.setInt(15, b.getRooms());
            
            int affectedRows = ps.executeUpdate();
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        return generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Booking> getBookingsByUser(int userId) {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, d.name as dest_name, h.name as hotel_name " +
                     "FROM bookings b " +
                     "LEFT JOIN destinations d ON b.destination_id = d.id " +
                     "LEFT JOIN hotels h ON b.hotel_id = h.id " +
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
        String sql = "SELECT b.*, d.name as dest_name, h.name as hotel_name " +
                     "FROM bookings b " +
                     "LEFT JOIN destinations d ON b.destination_id = d.id " +
                     "LEFT JOIN hotels h ON b.hotel_id = h.id " +
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
        b.setContactName(rs.getString("contact_name"));
        b.setContactMobile(rs.getString("contact_mobile"));
        b.setEmail(rs.getString("email"));
        b.setTotalCost(rs.getDouble("total_cost"));
        b.setStatus(rs.getString("status"));
        b.setBookingDate(rs.getTimestamp("booking_date"));
        
        b.setDestinationName(rs.getString("dest_name"));
        b.setHotelName(rs.getString("hotel_name"));
        
        b.setBookingType(rs.getString("booking_type"));
        b.setCheckIn(rs.getString("check_in"));
        b.setCheckOut(rs.getString("check_out"));
        b.setRoomType(rs.getString("room_type"));
        b.setAdults(rs.getInt("adults"));
        b.setChildren(rs.getInt("children"));
        b.setRooms(rs.getInt("rooms"));
        return b;
    }

    public boolean cancelBooking(int bookingId, int userId) {
        // Only allow cancellation if it's within 48 hours of booking
        String sql = "UPDATE bookings SET status = 'Cancelled' WHERE id = ? AND user_id = ? AND status = 'Successful' AND TIMESTAMPDIFF(HOUR, booking_date, NOW()) <= 48";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Booking getBookingById(int bookingId) {
        String sql = "SELECT b.*, d.name as dest_name, h.name as hotel_name " +
                     "FROM bookings b " +
                     "LEFT JOIN destinations d ON b.destination_id = d.id " +
                     "LEFT JOIN hotels h ON b.hotel_id = h.id " +
                     "WHERE b.id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return extractBooking(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateBookingDetails(int bookingId, int userId, String contactName, String contactMobile) {
        String sql = "UPDATE bookings SET contact_name=?, contact_mobile=? WHERE id=? AND user_id=? AND status='Successful'";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, contactName);
            ps.setString(2, contactMobile);
            ps.setInt(3, bookingId);
            ps.setInt(4, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean confirmBookingPayment(int bookingId) {
        String sql = "UPDATE bookings SET status = 'Successful' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean failBookingPayment(int bookingId) {
        String sql = "UPDATE bookings SET status = 'Pending' WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteBookingByAdmin(int bookingId) {
        String sql = "DELETE FROM bookings WHERE id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
