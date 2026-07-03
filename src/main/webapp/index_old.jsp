<%@ page import="com.ecotravel.dao.DestinationDao" %>
<%@ page import="com.ecotravel.model.Destination" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    DestinationDao destDao = new DestinationDao();
    List<Destination> topDestinations = destDao.getAllDestinations();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>EcoTravel | Green Tour Planning Portal</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        .hero {
            background: linear-gradient(rgba(46,125,50,0.6), rgba(46,125,50,0.6)), 
                        url('https://images.unsplash.com/photo-1501854140801-50d01698950b?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80') center/cover !important;
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="logo" style="font-size: 1.4rem;">🌿 EcoTravel - Green Tour Planning Portal</div>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="#tours">Green Tours</a></li>
            <li><a href="admin_login.jsp" class="btn-primary">Sign Up / Login</a></li>
        </ul>
    </nav>

    <header class="hero">
        <div class="hero-content">
            <h1>Welcome to<br><span>EcoTravel Karnataka</span></h1>
            <p>Embrace the Earth – Sustainable Adventures Across Karnataka. Your premier portal for responsible and eco-friendly tourism.</p>
            <a href="destinations" class="btn-hero">Start Planning Your Journey</a>
        </div>
    </header>

    <section id="tours" class="tours-section">
        <h2 class="section-title">Featured Eco-Tours</h2>
        <div class="tour-grid">
            <% for(int i=0; i < topDestinations.size(); i++) { 
                 Destination d = topDestinations.get(i);
            %>
            <div class="tour-card" onclick="window.location.href='destinations?action=view&id=<%= d.getId() %>'" style="cursor:pointer;">
                <div class="tour-image" style="background-image: url('<%= d.getImageUrl() %>');"></div>
                <div class="tour-info">
                    <h3><%= d.getName() %></h3>
                    <p><%= d.getDescription() %></p>
                    <div class="tour-meta">
                        <span title="Eco-Rating: <%= d.getEcoScore() %>/5" style="color: #fbc02d; font-weight: bold; font-size: 1.1rem;">
                            <%= d.getEcoScore() %>*
                        </span>
                        <span class="price">₹<%= d.getBasePrice() %></span>
                    </div>
                </div>
            </div>
            <% } %>
        </div>
    </section>

    <footer>
        <p>&copy; 2026 EcoTravel Karnataka. Promoting Sustainable Tourism.</p>
    </footer>
</body>
</html>
