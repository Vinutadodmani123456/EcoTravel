<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard - EcoTravel</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #2e7d32; color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 1000px; margin: 20px auto; padding: 20px; }
        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 25px; }
        .card { background: white; border-radius: 16px; box-shadow: 0 4px 20px rgba(0,0,0,0.08); transition: transform 0.3s, box-shadow 0.3s; overflow: hidden;}
        .card:hover { transform: translateY(-6px); box-shadow: 0 12px 35px rgba(0,0,0,0.15); }
        .btn { padding: 10px 15px; background: #2e7d32; color: white; text-decoration:none; border-radius:4px; display:inline-block; }
        .btn:hover { background: #1b5e20; }
        .hero { background: #c8e6c9; padding: 30px; border-radius: 12px; margin-bottom: 30px; text-align: center; }
    </style>
</head>
<body>
    <div class="nav">
        <div style="font-size: 1.4em; font-weight: bold;">🌿 EcoTravel Karnataka</div>
        <div>
            <a href="destinations" style="margin-right: 15px;">Explore Destinations</a>
<% if (user != null && "admin".equals(user.getRole())) { %>
                <a href="destinations?action=admin">Admin Panel</a>
                <a href="auth?action=logout">Logout</a>
            <% } else if (user != null) { %>
                <a href="profile.jsp">My Profile</a>
                <a href="bookings">My Bookings</a>
                <a href="auth?action=logout">Logout</a>
            <% } else { %>
                <a href="admin_login.jsp">Admin Login</a>
            <% } %>
        </div>
    </div>
    <div class="container">
        <div class="hero">
            <h2 style="color: #1b5e20;">Explore Tours in Karnataka!</h2>
        </div>
        
        <h3 style="color:#2e7d32; border-bottom:2px solid #a5d6a7; padding-bottom:10px;">Karnataka's Top Ecotourism Spots</h3>
        <div class="card-grid">
            <c:forEach var="dest" items="${destinations}">
                <div class="card" onclick="window.location.href='destinations?action=view&id=${dest.id}'" style="cursor: pointer; padding: 0; overflow: hidden; border-radius: 12px; display: flex; flex-direction: column;">
                    <img src="${dest.imageUrl}" alt="${dest.name}" style="width:100%; height:220px; object-fit:cover; display:block;" onerror="this.src='https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=600&q=80'">
                    <div style="padding: 15px; text-align: center;">
                        <h4 style="margin: 0; color: #1b5e20; font-size: 1.2rem; font-weight: 700;">${dest.name}</h4>
                    </div>
                </div>
            </c:forEach>
            <c:if test="${not empty param.bookingType}">
    <div class="success-msg" style="background:#d4edda; color:#155724; border:1px solid #c3e6cb; padding:15px; border-radius:4px; margin-bottom:20px; text-align:center;">
        <strong>✅ Your stay at ${param.hotelName} in ${param.destinationName} has been confirmed.</strong><br/><br/>
        <strong>EcoTravel - Green Tour Planning Portal</strong><br/>
        --------------------------------------------<br/>
        Booking Confirmed!<br/><br/>
        Hello, thank you for choosing a sustainable adventure with EcoTravel.<br/><br/>
        Your green trip has been validated and confirmed. We are excited to have you on board for a responsible travel experience!<br/><br/>
        <strong>Booking Status:</strong> Confirmed<br/>
        <strong>Eco-Score:</strong> High<br/><br/>
        Visit our portal for more details. Have a safe and green journey!<br/>
        --------------------------------------------<br/>
        Travel Responsibly, Travel Green. EcoTravel - Green Tour Planning Portal<br/>
        --------------------------------------------
    </div>
</c:if>
<c:if test="${empty destinations}">
                <div style="text-align: center; width: 100%; color: #666; padding: 20px;">No eco-destinations match your criteria. Please lower your required eco-score.</div>
            </c:if>
        </div>
    </div>
    
    <script src="app.js"></script>
</body>
</html>
