package com.ecotravel.model;

import java.sql.Timestamp;

public class Booking {
    private int id;
    private int userId;
    private int destinationId;
    private int hotelId;
    private String contactName;
    private String contactMobile;
    private String email;
    private double totalCost;
    private String status;
    private Timestamp bookingDate;

    // Transient fields
    private String destinationName;
    private String hotelName;

    public Booking() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }
    public int getHotelId() { return hotelId; }
    public void setHotelId(int hotelId) { this.hotelId = hotelId; }

    public String getContactName() { return contactName; }
    public void setContactName(String contactName) { this.contactName = contactName; }
    public String getContactMobile() { return contactMobile; }
    public void setContactMobile(String contactMobile) { this.contactMobile = contactMobile; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public double getTotalCost() { return totalCost; }
    public void setTotalCost(double totalCost) { this.totalCost = totalCost; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public Timestamp getBookingDate() { return bookingDate; }
    public void setBookingDate(Timestamp bookingDate) { this.bookingDate = bookingDate; }

    public String getDestinationName() { return destinationName; }
    public void setDestinationName(String destinationName) { this.destinationName = destinationName; }
    public String getHotelName() { return hotelName; }
    public void setHotelName(String hotelName) { this.hotelName = hotelName; }

    private String bookingType;
    private String checkIn;
    private String checkOut;
    private String roomType;
    private int adults;
    private int children;
    private int rooms;

    public String getBookingType() { return bookingType; }
    public void setBookingType(String bookingType) { this.bookingType = bookingType; }
    public String getCheckIn() { return checkIn; }
    public void setCheckIn(String checkIn) { this.checkIn = checkIn; }
    public String getCheckOut() { return checkOut; }
    public void setCheckOut(String checkOut) { this.checkOut = checkOut; }
    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }
    
    public int getAdults() { return adults; }
    public void setAdults(int adults) { this.adults = adults; }
    
    public int getChildren() { return children; }
    public void setChildren(int children) { this.children = children; }
    
    public int getRooms() { return rooms; }
    public void setRooms(int rooms) { this.rooms = rooms; }
}
