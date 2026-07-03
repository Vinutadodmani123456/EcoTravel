<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("user_login.jsp?msg=Please+login+to+book");
        return;
    }

    int destId = 0;
    try {
        destId = Integer.parseInt(request.getParameter("destId"));
    } catch(Exception e) {}

    com.ecotravel.dao.DestinationDao destDao = new com.ecotravel.dao.DestinationDao();
    com.ecotravel.model.Destination dest = null;
    for (com.ecotravel.model.Destination d : destDao.getAllDestinations()) {
        if (d.getId() == destId) {
            dest = d;
            break;
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Confirm Destination Booking - EcoTravel Karnataka</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Outfit', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #2e7d32; color: white; padding: 15px; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 800px; margin: 40px auto; background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.06); }
        h2 { color: #1b5e20; border-bottom: 2px solid #c8e6c9; padding-bottom: 10px; margin-top: 0; }
        .form-group { margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color:#2e7d32;}
        input[type="text"], input[type="email"], select { width: 100%; padding: 12px; border: 1.5px solid #ccc; border-radius: 8px; font-size:16px; box-sizing:border-box;}
        input[type="text"]:focus, input[type="email"]:focus, select:focus { border-color: #2e7d32; outline: none; }
        .btn { padding: 15px 20px; background: #2e7d32; color: white; border:none; border-radius:8px; font-size:18px; cursor:pointer; width:100%; font-weight:bold; box-shadow: 0 4px 12px rgba(46,125,50,0.2); transition: all 0.2s;}
        .btn:hover { background: #1b5e20; box-shadow: 0 6px 15px rgba(46,125,50,0.3); }
        .eco-badge { background:#4caf50; color:white; padding:4px 8px; border-radius:4px; font-weight:bold; }
    </style>
</head>
<body>
    <div class="nav">
        <span style="font-size: 1.2em; font-weight: bold;">🌿 EcoTravel Karnataka</span>
        <a href="destinations?action=view&id=<%= destId %>">Back to Destination</a>
    </div>
    <div class="container">
        <h2>Confirm Your Destination Booking Details</h2>
        <p style="font-size:1.1em; color:#555;">Please confirm traveler details below to book your eco-friendly tour.</p>
        
        <form action="bookings" method="post" style="margin-top:30px;">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="bookingType" value="destination">
            <input type="hidden" name="destId" value="<%= destId %>">
            <input type="hidden" name="hotelId" value="0">

            
            <h3 style="color:#2e7d32; margin-top:30px;">1. Passenger Details</h3>
            <div class="form-group">
                <label>Passenger Full Name</label>
                <input type="text" name="contactName" 
                       value="<%= user != null ? user.getUsername() : "" %>"
                       placeholder="Enter traveler's name" 
                       pattern="[A-Za-z\s]+" title="Name must contain only letters" required
                       oninput="this.value = this.value.replace(/[^A-Za-z\s]/g, '')">
            </div>
            <div class="form-group">
                <label>Mobile Number</label>
                <input type="text" name="contactMobile" placeholder="e.g. 9876543210" required 
                       pattern="\d{10}" maxlength="10" title="Please enter exactly 10 digits"
                       oninput="this.value = this.value.replace(/[^0-9]/g, '')">
            </div>
            <div class="form-group">
                <label>Email ID</label>
                <input type="email" name="contactEmail" value="<%= user != null ? user.getEmail() : "" %>" placeholder="e.g. user@example.com" required 
                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$"
                       title="Please enter a valid email address with a dot (e.g., .com)">
            </div>
            
            <div style="background:#e8f5e9; border:2px solid #81c784; padding:20px; border-radius:10px; margin-top:20px; margin-bottom: 25px;">
                <h4 style="margin:0 0 10px 0; color:#2e7d32; font-size:1.15rem;">📊 Destination Cost Summary</h4>
                <p style="margin:5px 0; color:#444;"><strong>Destination:</strong> <%= dest != null ? dest.getName() : "N/A" %></p>
                <p style="margin:5px 0; color:#444;"><strong>Eco-Score:</strong> <span style="color:#fbc02d; font-weight:bold;"><%= dest != null ? dest.getEcoScore() : "0" %>*</span></p>
                <p style="margin:15px 0 0 0; font-size:1.25rem; font-weight:bold; color:#1b5e20;">Total Price: ₹<%= dest != null ? dest.getBasePrice() : "0.0" %></p>
            </div>

            <h3 style="color:#2e7d32; margin-top:30px;">2. Zero-Plastic Digital Pledge</h3>
            <div class="form-group" style="background:#fff3e0; padding:15px; border-radius:8px; border-left:4px solid #ff9800; margin-bottom: 30px;">
                <label style="display:flex; align-items:center; cursor:pointer;">
                    <input type="checkbox" required style="width:20px; height:20px; margin-right:12px;">
                    <span style="color:#333; font-weight:normal; line-height:1.4;">I officially pledge to carry <strong>ZERO single-use plastics</strong> into this ecosystem. I understand this pledge acts as my verifiable Digital Green Pass.</span>
                </label>
            </div>

            <button type="submit" class="btn">Confirm Details & Book Now</button>
        </form>
    </div>
</body>
</html>
