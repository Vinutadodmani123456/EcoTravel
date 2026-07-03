package com.ecotravel.model;

public class Hotel {
    private int id;
    private int destinationId;
    private String name;
    private String description;
    private String imageUrl;
    private int ecoRating;
    private double pricePerNight;

    public Hotel() {}

    public Hotel(int id, int destinationId, String name, String description, String imageUrl, int ecoRating, double pricePerNight) {
        this.id = id;
        this.destinationId = destinationId;
        this.name = name;
        this.description = description;
        this.imageUrl = imageUrl;
        this.ecoRating = ecoRating;
        this.pricePerNight = pricePerNight;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public int getEcoRating() { return ecoRating; }
    public void setEcoRating(int ecoRating) { this.ecoRating = ecoRating; }
    public double getPricePerNight() { return pricePerNight; }
    public void setPricePerNight(double pricePerNight) { this.pricePerNight = pricePerNight; }
}
