package com.ecotravel.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = getEnvOrDefault("DB_URL", "jdbc:mysql://localhost:3306/ecotravel?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true");
    private static final String USER = getEnvOrDefault("DB_USER", "root");
    private static final String PASSWORD = getEnvOrDefault("DB_PASSWORD", "Vinuta@1234");

    public static String getEnvOrDefault(String name, String defaultValue) {
        String value = System.getenv(name);
        if (value == null || value.trim().isEmpty()) {
            return defaultValue;
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
