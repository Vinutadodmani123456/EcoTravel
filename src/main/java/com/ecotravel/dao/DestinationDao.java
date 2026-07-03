package com.ecotravel.dao;

import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;

import com.ecotravel.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DestinationDao {

    public List<Destination> getAllDestinations() {
        List<Destination> list = new ArrayList<>();
        String sql = "SELECT * FROM destinations ORDER BY eco_score DESC";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return list;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                list.add(new Destination(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getInt("eco_score"),
                    rs.getString("image_url"),
                    rs.getDouble("base_price"),
                    rs.getString("map_embed")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void addDestination(Destination d) {
        String sql = "INSERT INTO destinations (name, description, eco_score, image_url, base_price, map_embed) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, d.getName());
            ps.setString(2, d.getDescription());
            ps.setInt(3, d.getEcoScore());
            ps.setString(4, d.getImageUrl());
            ps.setDouble(5, d.getBasePrice());
            ps.setString(6, d.getMapEmbed());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Hotel> getHotelsByDestination(int destinationId) {
        List<Hotel> list = new ArrayList<>();
        String sql = "SELECT * FROM hotels WHERE destination_id = ?";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return list;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Hotel(
                    rs.getInt("id"),
                    rs.getInt("destination_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getInt("eco_rating"),
                    rs.getDouble("price_per_night")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteDestination(int id) {
        String delHotels = "DELETE FROM hotels WHERE destination_id = ?";
        String delBookings = "DELETE FROM bookings WHERE destination_id = ?";
        String delDest = "DELETE FROM destinations WHERE id = ?";
        
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return;
        }
        try (Connection ignored = conn) {
            try (PreparedStatement ps1 = conn.prepareStatement(delBookings)) { ps1.setInt(1, id); ps1.executeUpdate(); }
            try (PreparedStatement ps2 = conn.prepareStatement(delHotels)) { ps2.setInt(1, id); ps2.executeUpdate(); }
            try (PreparedStatement ps4 = conn.prepareStatement(delDest)) { ps4.setInt(1, id); ps4.executeUpdate(); }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDestination(int id, String name, int ecoScore, double basePrice, String desc, String imageUrl) {
        String sql = "UPDATE destinations SET name=?, eco_score=?, base_price=?, description=?, image_url=? WHERE id=?";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, ecoScore);
            ps.setDouble(3, basePrice);
            ps.setString(4, desc);
            ps.setString(5, imageUrl);
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public void addHotel(Hotel h) {
        String sql = "INSERT INTO hotels (destination_id, name, description, image_url, eco_rating, price_per_night) VALUES (?, ?, ?, ?, ?, ?)";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, h.getDestinationId());
            ps.setString(2, h.getName());
            ps.setString(3, h.getDescription());
            ps.setString(4, h.getImageUrl());
            ps.setInt(5, h.getEcoRating());
            ps.setDouble(6, h.getPricePerNight());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }


    public List<Hotel> getAllHotels() {
        List<Hotel> list = new ArrayList<>();
        // Using JOIN to only show hotels for destinations that actually exist
        String sql = "SELECT h.* FROM hotels h INNER JOIN destinations d ON h.destination_id = d.id";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return list;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                list.add(new Hotel(
                    rs.getInt("id"),
                    rs.getInt("destination_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getInt("eco_rating"),
                    rs.getDouble("price_per_night")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public Hotel getHotelById(int hotelId) {
        String sql = "SELECT * FROM hotels WHERE id = ?";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return null;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, hotelId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Hotel(
                    rs.getInt("id"),
                    rs.getInt("destination_id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getString("image_url"),
                    rs.getInt("eco_rating"),
                    rs.getDouble("price_per_night")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Retrieve a destination by its ID
    public Destination getDestinationById(int destinationId) {
        String sql = "SELECT * FROM destinations WHERE id = ?";
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            System.err.println("Failed to obtain DB connection");
            return null;
        }
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Destination(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getInt("eco_score"),
                    rs.getString("image_url"),
                    rs.getDouble("base_price"),
                    rs.getString("map_embed")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
