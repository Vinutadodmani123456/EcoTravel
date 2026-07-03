<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("user") == null) {
        response.sendRedirect("user_auth.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - EcoTravel</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #2e7d32; color: white; padding: 15px; display:flex; justify-content:space-between; align-items:center; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 1000px; margin: 30px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); overflow-x:auto;}
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { padding: 15px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #e8f5e9; color: #1b5e20; }
        .success-msg { color: #155724; background-color: #d4edda; border: 1px solid #c3e6cb; padding: 15px; border-radius: 4px; margin-bottom: 20px; text-align:center; }
    </style>
</head>
<body>
    <div class="nav">
        <span style="font-size: 1.4em; font-weight: bold;">🌿 EcoTravel Karnataka</span>
        <div>
            <a href="destinations">Explore</a>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>
    <div class="container">
        <h2 style="color: #2e7d32; text-align:center; border-bottom:2px solid #a5d6a7; padding-bottom:10px;">My Confirmed Eco-Trips</h2>
        
        <% if (request.getParameter("msg") != null) { %>
            <div class="success-msg"><%= request.getParameter("msg") %></div>
        <% } %>

        <div style="display:grid; grid-template-columns: repeat(auto-fill, minmax(350px, 1fr)); gap:20px; margin-top:20px;">
            <c:forEach var="b" items="${bookings}">
                <div style="background:white; border:2px solid #2e7d32; border-radius:12px; display:flex; flex-direction:column; overflow:hidden; box-shadow:0 4px 10px rgba(0,0,0,0.1);">
                    <div style="background:#2e7d32; color:white; padding:15px; display:flex; justify-content:space-between; align-items:center;">
                        <span style="font-weight:bold; font-size:1.2em;">DIGITAL GREEN PASS</span>
                        <span style="background:white; color:#2e7d32; padding:3px 8px; border-radius:4px; font-weight:bold; font-size:0.9em;">ID: #${b.id}</span>
                    </div>
                    <div style="padding:20px; background:#f4fdf4;">
                        <h3 style="margin:0 0 10px 0; color:#1b5e20;">${b.destinationName}</h3>
                        <p style="margin:5px 0;"><strong>Passenger:</strong> ${b.contactName} (${b.contactMobile})</p>
                        <p style="margin:5px 0;"><strong>Accommodation:</strong> ${b.hotelName}</p>
                        <p style="margin:5px 0;"><strong>Green Transit:</strong> ${b.transportType}</p>
                        <hr style="border:0; border-top:1px dashed #a5d6a7; margin:15px 0;">
                        <div style="display:flex; justify-content:space-between; align-items:center; flex-wrap:wrap; gap:10px;">
                            <span style="font-size:1.2em; font-weight:bold; color:#d32f2f;">Total: ₹${b.totalCost}</span>
                            <span style="color:green; font-weight:bold; background:#e8f5e9; padding:5px 10px; border-radius:20px; font-size:0.9em;">✓ ${b.status}</span>
                        </div>
                        <p style="margin:15px 0 0 0; text-align:center; color:#555; font-size:0.85em;">Authorized Booking: ${b.bookingDate}</p>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${empty bookings}">
                <div style="grid-column: 1 / -1; text-align:center; padding:30px; color:#555; background:white; border-radius:8px;">No eco-trips found. It's time to explore the greener side of Karnataka!</div>
            </c:if>
        </div>
    </div>
    <% if (request.getParameter("sms") != null) { %>
        <script>
            alert("💬 SMS SUCCESSFULLY SENT to +91-<%= request.getParameter("sms") %>:\n\n'Hello! Your EcoTravel Green Trip has been validated and confirmed. Your Zero-Plastic Pledge acts as your Digital Green Pass. Have a safe journey!'");
        </script>
    <% } %>
</body>
</html>
