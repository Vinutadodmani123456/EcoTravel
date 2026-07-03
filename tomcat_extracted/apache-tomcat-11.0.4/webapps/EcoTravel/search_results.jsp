<%@ page import="com.ecotravel.model.Hotel" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    List<Hotel> searchResults = (List<Hotel>) request.getAttribute("searchResults");
    String location = (String) request.getAttribute("location");
    String checkIn = (String) request.getAttribute("checkIn");
    String checkOut = (String) request.getAttribute("checkOut");
    String adults = (String) request.getAttribute("adults");
    String children = (String) request.getAttribute("children");
    String rooms = (String) request.getAttribute("rooms");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Search Results - EcoTravel Hotels</title>
    <link rel="stylesheet" href="style.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        body { background-color: #f5f7fa; font-family: 'Outfit', sans-serif; }
        .nav { background: #1b5e20; color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .search-header { background: #00224f; color: white; padding: 20px 0; text-align: center; }
        .search-info { font-size: 1.2rem; }
        .results-container { max-width: 1000px; margin: 30px auto; padding: 0 20px; }
        .results-title { font-size: 1.5rem; color: #333; margin-bottom: 20px; font-weight: bold; }
        .hotel-card { background: white; border: 1px solid #e0e0e0; border-radius: 8px; display: flex; overflow: hidden; margin-bottom: 20px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .hotel-img { width: 300px; height: 200px; object-fit: cover; }
        .hotel-details { padding: 20px; flex: 1; display: flex; flex-direction: column; justify-content: space-between; }
        .hotel-title { font-size: 1.4rem; color: #005eb8; font-weight: bold; margin: 0; }
        .hotel-location { color: #0071c2; font-size: 0.9rem; margin-top: 5px; text-decoration: underline; cursor: pointer; }
        .eco-badge { background: #fbc02d; color: #333; padding: 3px 8px; border-radius: 4px; font-size: 0.8rem; font-weight: bold; display: inline-block; margin-top: 10px; }
        .hotel-desc { color: #666; font-size: 0.95rem; margin-top: 10px; }
        .price-section { text-align: right; padding-left: 20px; border-left: 1px solid #e0e0e0; min-width: 200px; display: flex; flex-direction: column; justify-content: flex-end; }
        .price-note { font-size: 0.85rem; color: #666; }
        .price-amount { font-size: 1.8rem; font-weight: bold; color: #333; margin: 5px 0; }
        .btn-book { background: #0071c2; color: white; text-decoration: none; padding: 10px 20px; border-radius: 4px; font-weight: bold; text-align: center; display: block; margin-top: 15px; }
        .btn-book:hover { background: #005eb8; }
    </style>
</head>
<body>
    <div class="nav">
        <div style="font-size: 1.4em; font-weight: bold;">🌿 EcoTravel</div>
        <div>
            <a href="index.jsp">Home</a>
        </div>
    </div>
    
    <div class="search-header">
        <div class="search-info">
            <strong><%= location != null ? location.substring(0, 1).toUpperCase() + location.substring(1) : "Search" %></strong> • <%= checkIn %> to <%= checkOut %> • <%= adults %> Adults, <%= children %> Children, <%= rooms %> Room(s)
        </div>
    </div>

    <div class="results-container">
        <% if (searchResults != null && !searchResults.isEmpty()) { %>
            <div class="results-title">We found <%= searchResults.size() %> places to stay for you</div>
            
            <% for (Hotel h : searchResults) { %>
                <div class="hotel-card">
                    <img src="<%= h.getImageUrl() %>" alt="<%= h.getName() %>" class="hotel-img">
                    <div class="hotel-details">
                        <div>
                            <h3 class="hotel-title"><%= h.getName() %></h3>
                            <div class="hotel-location">Show on map</div>
                            <div class="eco-badge">Eco Rating: <%= h.getEcoRating() %> / 5</div>
                            <p class="hotel-desc"><%= h.getDescription() %></p>
                            <p style="color: #008009; font-weight: bold; font-size: 0.9rem; margin-top: 10px;">✓ Free cancellation<br>✓ Breakfast included</p>
                        </div>
                    </div>
                    <div class="price-section">
                        <div class="price-note">1 night, <%= adults %> adults</div>
                        <div class="price-amount">₹<%= h.getPricePerNight() %></div>
                        <div class="price-note">+ taxes and fees</div>
                        <!-- Pass search parameters to hotel_booking.jsp -->
                        <a href="hotel_booking.jsp?hotelId=<%= h.getId() %>&checkIn=<%= checkIn %>&checkOut=<%= checkOut %>&adults=<%= adults %>&children=<%= children %>&rooms=<%= rooms %>" class="btn-book">See all options ></a>
                    </div>
                </div>
            <% } %>
            
        <% } else { %>
            <div class="results-title" style="text-align: center; margin-top: 50px;">
                <h2>No properties found in "<%= location %>"</h2>
                <p>Try searching for a different destination like "Sakleshpur" or "Chikmagalur".</p>
                <a href="index.jsp" class="btn-book" style="display: inline-block; padding: 12px 30px;">Go Back</a>
            </div>
        <% } %>
    </div>
</body>
</html>
