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
        .card-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); transition: transform 0.2s; overflow: hidden;}
        .card:hover { transform: translateY(-5px); }
        .btn { padding: 10px 15px; background: #2e7d32; color: white; text-decoration:none; border-radius:4px; display:inline-block; }
        .btn:hover { background: #1b5e20; }
        .hero { background: #c8e6c9; padding: 30px; border-radius: 8px; margin-bottom: 20px; text-align: center; }
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
            <% } else { %>
                <a href="admin_login.jsp">Admin Login</a>
            <% } %>
        </div>
    </div>
    <div class="container">
        <div class="hero">
            <h2 style="color: #1b5e20;">Plan Your Green Adventure in Karnataka!</h2>
        </div>
        
        <h3 style="color:#2e7d32; border-bottom:2px solid #a5d6a7; padding-bottom:10px;">Karnataka's Top Ecotourism Spots</h3>
        <div class="card-grid">
            <c:forEach var="dest" items="${destinations}">
                <div class="card">
                    <h4>${dest.name}</h4>
                    <img src="${dest.imageUrl}" alt="${dest.name}" style="width:100%; height:200px; object-fit:cover; border-radius:8px; margin-top:5px;">
                    <div style="margin: 10px 0; border-radius: 8px; overflow:hidden;">${dest.mapEmbed}</div>
                    <p style="font-size: 0.95em; color: #444;">${dest.description}</p>
                    <p><strong>Base Trip Price:</strong> <span style="color:#d32f2f; font-weight:bold;">₹${dest.basePrice}</span></p>
                    <p><strong>Eco-Score:</strong> <span style="background:#4caf50; color:white; padding:2px 8px; border-radius:12px; font-weight:bold;">${dest.ecoScore}/10</span></p>
                    <a href="destinations?action=view&id=${dest.id}" class="btn" style="width:100%; box-sizing:border-box; text-align:center; margin-top: 15px;">View Options & Book</a>
                </div>
            </c:forEach>
            <c:if test="${empty destinations}">
                <div style="text-align: center; width: 100%; color: #666;">No eco-destinations match your criteria. Please lower your required eco-score.</div>
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
