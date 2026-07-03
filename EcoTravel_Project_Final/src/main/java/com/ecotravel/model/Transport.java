package com.ecotravel.model;

public class Transport {
    private int id;
    private int destinationId;
    private String type;
    private String carbonFootprint;
    private double price;

    public Transport() {}

    public Transport(int id, int destinationId, String type, String carbonFootprint, double price) {
        this.id = id;
        this.destinationId = destinationId;
        this.type = type;
        this.carbonFootprint = carbonFootprint;
        this.price = price;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }
    public String getType() { return type; }
    public void setType(String type) { this.type = type; }
    public String getCarbonFootprint() { return carbonFootprint; }
    public void setCarbonFootprint(String carbonFootprint) { this.carbonFootprint = carbonFootprint; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
}
