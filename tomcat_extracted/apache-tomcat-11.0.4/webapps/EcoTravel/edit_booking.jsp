<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    if (session.getAttribute("user") == null) { response.sendRedirect("user_login.jsp"); return; }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Modify Booking - EcoTravel Karnataka</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #2e7d32; color: white; padding: 15px; display: flex; justify-content: space-between; align-items: center;}
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 600px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { color: #1b5e20; border-bottom: 2px solid #c8e6c9; padding-bottom: 10px; text-align: center; }
        .form-group { margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color:#2e7d32;}
        input[type="text"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size:16px; box-sizing:border-box;}
        .btn { padding: 15px 20px; background: #2e7d32; color: white; border:none; border-radius:4px; font-size:18px; cursor:pointer; width:100%; font-weight:bold;}
        .btn:hover { background: #1b5e20; }
        .info-box { background:#e8f5e9; border:2px solid #81c784; padding:15px; border-radius:8px; margin-bottom:20px; }
    </style>
</head>
<body>
    <div class="nav">
        <span style="font-size: 1.2em; font-weight: bold;">🌿 EcoTravel Karnataka</span>
        <div>
            <a href="bookings">Back to My Bookings</a>
        </div>
    </div>
    <div class="container">
        <h2>Modify Your Eco-Trip Booking</h2>
        
        <div class="info-box">
            <h4 style="margin:0 0 5px 0; color:#2e7d32;">Trip: ${booking.destinationName}</h4>
            <p style="margin:0; font-size:0.9em; color:#555;">Booking ID: #${booking.id}</p>
            <p style="margin:5px 0 0 0; font-size:0.9em; color:#d32f2f;"><em>Note: You can only update passenger details. To change the destination, please cancel and re-book.</em></p>
        </div>

        <form action="bookings" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="bookingId" value="${booking.id}">
            
            <div class="form-group">
                <label>Passenger Full Name</label>
                <input type="text" name="contactName" value="${booking.contactName}" required>
            </div>
            <div class="form-group">
                <label>Mobile Number</label>
                <input type="text" name="contactMobile" value="${booking.contactMobile}" required pattern="\d{10}" maxlength="10" title="Please enter exactly 10 digits">
            </div>

            <button type="submit" class="btn">Save Modified Details</button>
        </form>
    </div>
</body>
</html>
