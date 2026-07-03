-- Run this in MySQL / phpMyAdmin to clean up placeholder hotels
USE ecotravel;

-- Delete all old placeholder hotels (IDs 1 to 9 from data.sql)
-- This keeps any hotels the admin added via the portal (auto-increment IDs like 10, 11...)
DELETE FROM hotels WHERE id BETWEEN 1 AND 9;
