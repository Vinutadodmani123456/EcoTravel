package com.ecotravel.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = requiredEnv("DB_URL");
    private static final String USER = requiredEnv("DB_USER");
    private static final String PASSWORD = requiredEnv("DB_PASSWORD");

    private static String requiredEnv(String name) {
        String value = System.getenv(name);
        if (value == null || value.isBlank()) {
            throw new IllegalStateException("Missing required environment variable: " + name);
        }
        return value;
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.err.println("JDBC Driver not found or DB Connection error: " + e.getMessage());
        }
        return conn;
    }
}
