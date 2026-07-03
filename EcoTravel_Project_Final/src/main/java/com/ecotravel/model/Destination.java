package com.ecotravel.model;

public class Destination {
    private int id;
    private String name;
    private String description;
    private int ecoScore;
    private String imageUrl;
    private double basePrice;
    private String mapEmbed;

    public Destination() {}

    public Destination(int id, String name, String description, int ecoScore, String imageUrl, double basePrice, String mapEmbed) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.ecoScore = ecoScore;
        this.imageUrl = imageUrl;
        this.basePrice = basePrice;
        this.mapEmbed = mapEmbed;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public int getEcoScore() { return ecoScore; }
    public void setEcoScore(int ecoScore) { this.ecoScore = ecoScore; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public double getBasePrice() { return basePrice; }
    public void setBasePrice(double basePrice) { this.basePrice = basePrice; }
    public String getMapEmbed() { return mapEmbed; }
    public void setMapEmbed(String mapEmbed) { this.mapEmbed = mapEmbed; }
}
