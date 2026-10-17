package com.ecotravel.util;

import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

@WebListener
public class DBInitializer implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent event) {
        try (Connection connection = DBConnection.getConnection()) {
            if (connection == null) {
                throw new SQLException("Could not connect to the ecotravel database.");
            }

            executeScript(connection, "/database/schema.sql");
            executeScript(connection, "/database/data.sql");
            event.getServletContext().log("EcoTravel database schema and sample data are ready.");
        } catch (IOException | SQLException e) {
            event.getServletContext().log("Failed to initialize the EcoTravel database.", e);
            throw new IllegalStateException("EcoTravel database initialization failed.", e);
        }
    }

    private void executeScript(Connection connection, String resourcePath) throws IOException, SQLException {
        InputStream resource = DBInitializer.class.getResourceAsStream(resourcePath);
        if (resource == null) {
            throw new IOException("Database script not found: " + resourcePath);
        }

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(resource, StandardCharsets.UTF_8));
             Statement statement = connection.createStatement()) {
            StringBuilder sql = new StringBuilder();
            boolean inString = false;
            boolean escaped = false;
            int next;

            while ((next = reader.read()) != -1) {
                char current = (char) next;
                if (inString) {
                    sql.append(current);
                    if (escaped) {
                        escaped = false;
                    } else if (current == '\\') {
                        escaped = true;
                    } else if (current == '\'') {
                        inString = false;
                    }
                } else if (current == '\'') {
                    inString = true;
                    sql.append(current);
                } else if (current == ';') {
                    executeStatement(statement, sql);
                } else {
                    sql.append(current);
                }
            }

            executeStatement(statement, sql);
        }
    }

    private void executeStatement(Statement statement, StringBuilder sql) throws SQLException {
        String command = sql.toString().trim();
        sql.setLength(0);
        if (!command.isEmpty()) {
            statement.execute(command);
        }
    }
}
