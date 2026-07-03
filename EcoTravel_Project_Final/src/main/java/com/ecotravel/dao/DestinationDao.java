package com.ecotravel.dao;

import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;
import com.ecotravel.model.Transport;
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
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
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
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
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

    public List<Transport> getTransportByDestination(int destinationId) {
        List<Transport> list = new ArrayList<>();
        String sql = "SELECT * FROM transport WHERE destination_id = ?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, destinationId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(new Transport(
                    rs.getInt("id"),
                    rs.getInt("destination_id"),
                    rs.getString("type"),
                    rs.getString("carbon_footprint"),
                    rs.getDouble("price")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public void deleteDestination(int id) {
        String delHotels = "DELETE FROM hotels WHERE destination_id = ?";
        String delTransport = "DELETE FROM transport WHERE destination_id = ?";
        String delBookings = "DELETE FROM bookings WHERE destination_id = ?";
        String delDest = "DELETE FROM destinations WHERE id = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            try (PreparedStatement ps1 = conn.prepareStatement(delBookings)) { ps1.setInt(1, id); ps1.executeUpdate(); }
            try (PreparedStatement ps2 = conn.prepareStatement(delHotels)) { ps2.setInt(1, id); ps2.executeUpdate(); }
            try (PreparedStatement ps3 = conn.prepareStatement(delTransport)) { ps3.setInt(1, id); ps3.executeUpdate(); }
            try (PreparedStatement ps4 = conn.prepareStatement(delDest)) { ps4.setInt(1, id); ps4.executeUpdate(); }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDestination(int id, String name, int ecoScore, double basePrice, String desc) {
        String sql = "UPDATE destinations SET name=?, eco_score=?, base_price=?, description=? WHERE id=?";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, name);
            ps.setInt(2, ecoScore);
            ps.setDouble(3, basePrice);
            ps.setString(4, desc);
            ps.setInt(5, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
