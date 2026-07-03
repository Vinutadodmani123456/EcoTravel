CREATE DATABASE IF NOT EXISTS ecotravel;
USE ecotravel;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    role VARCHAR(20) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS destinations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    eco_score INT CHECK (eco_score BETWEEN 1 AND 10),
    image_url VARCHAR(255),
    base_price DECIMAL(10, 2),
    map_embed TEXT
);

CREATE TABLE IF NOT EXISTS hotels (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    image_url VARCHAR(255),
    eco_rating INT CHECK (eco_rating BETWEEN 1 AND 5),
    price_per_night DECIMAL(10, 2),
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS transport (
    id INT AUTO_INCREMENT PRIMARY KEY,
    destination_id INT,
    type VARCHAR(50) NOT NULL,
    carbon_footprint VARCHAR(50),
    price DECIMAL(10, 2),
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS bookings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    destination_id INT,
    hotel_id INT,
    transport_id INT,
    contact_name VARCHAR(100) NOT NULL,
    contact_mobile VARCHAR(20) NOT NULL,
    total_cost DECIMAL(10, 2),
    status VARCHAR(20) DEFAULT 'Confirmed',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (destination_id) REFERENCES destinations(id) ON DELETE CASCADE,
    FOREIGN KEY (hotel_id) REFERENCES hotels(id) ON DELETE SET NULL,
    FOREIGN KEY (transport_id) REFERENCES transport(id) ON DELETE SET NULL
);
