<%@ page import="java.sql.*, com.ecotravel.util.DBConnection" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Database Debugger - EcoTravel</title>
    <style>
        body { font-family: monospace; padding: 20px; }
        table { border-collapse: collapse; margin-bottom: 30px; width: 100%; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background: #f0f0f0; }
        h2 { color: #2e7d32; }
    </style>
</head>
<body>
    <h1>EcoTravel Database Inspector</h1>

    <h2>Session Info</h2>
    <p>Session ID: <%= session.getId() %></p>
    <p>User in Session: <%= session.getAttribute("user") != null ? session.getAttribute("user").toString() : "NULL" %></p>
    <%
        if (session.getAttribute("user") != null) {
            com.ecotravel.model.User u = (com.ecotravel.model.User) session.getAttribute("user");
            out.println("<p>Logged In User ID: " + u.getId() + ", Username: " + u.getUsername() + ", Role: " + u.getRole() + "</p>");
        }
    %>

    <h2>Users Table</h2>
    <table>
        <tr>
            <th>ID</th><th>Username</th><th>Email</th><th>Password</th><th>Role</th>
        </tr>
        <%
            out.println("<p>URL: " + DBConnection.getEnvOrDefault("DB_URL", "DEFAULT_URL") + "</p>");
            out.println("<p>USER: " + DBConnection.getEnvOrDefault("DB_USER", "DEFAULT_USER") + "</p>");
            out.println("<p>PASS LEN: " + (DBConnection.getEnvOrDefault("DB_PASSWORD", "").length()) + "</p>");
            try {
                Connection conn = DBConnection.getConnection();
                out.println("<p>Conn object: " + conn + "</p>");
                if (conn != null) {
                    Statement stmt = conn.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM users");
                    while (rs.next()) {
                        out.println("<tr>");
                        out.println("<td>" + rs.getInt("id") + "</td>");
                        out.println("<td>" + rs.getString("username") + "</td>");
                        out.println("<td>" + rs.getString("email") + "</td>");
                        out.println("<td>" + rs.getString("password") + "</td>");
                        out.println("<td>" + rs.getString("role") + "</td>");
                        out.println("</tr>");
                    }
                    conn.close();
                }
            } catch (Throwable e) {
                out.println("<tr><td colspan='5'>Error: " + e.getClass().getName() + " - " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>

    <h2>Bookings Table</h2>
    <table>
        <tr>
            <th>ID</th><th>User ID</th><th>Dest ID</th><th>Hotel ID</th><th>Trans ID</th><th>Name</th><th>Mobile</th><th>Email</th><th>Total Cost</th><th>Status</th><th>Booking Date</th>
        </tr>
        <%
            try (Connection conn = DBConnection.getConnection();
                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT * FROM bookings")) {
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getInt("id") + "</td>");
                    out.println("<td>" + rs.getInt("user_id") + " (Was Null? " + (rs.getObject("user_id") == null ? "YES" : "NO") + ")</td>");
                    out.println("<td>" + rs.getInt("destination_id") + "</td>");
                    out.println("<td>" + rs.getInt("hotel_id") + "</td>");

                    out.println("<td>" + rs.getString("contact_name") + "</td>");
                    out.println("<td>" + rs.getString("contact_mobile") + "</td>");
                    out.println("<td>" + rs.getString("email") + "</td>");
                    out.println("<td>" + rs.getDouble("total_cost") + "</td>");
                    out.println("<td>" + rs.getString("status") + "</td>");
                    out.println("<td>" + rs.getTimestamp("booking_date") + "</td>");
                    out.println("</tr>");
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='11'>Error: " + e.getMessage() + "</td></tr>");
            }
        %>
    </table>
</body>
</html>
