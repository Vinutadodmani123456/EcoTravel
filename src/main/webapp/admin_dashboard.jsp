<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
    com.ecotravel.dao.DestinationDao dDao = new com.ecotravel.dao.DestinationDao();
    request.setAttribute("currentDestinations", dDao.getAllDestinations());
%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" href="/css/toast.css" />
    <style>
        body {font-family: 'Segoe UI', sans-serif; margin:0; background:#f4fdf4; display:flex; height:100vh;}
        .sidebar {width:250px; background:#1b5e20; color:white; padding:20px; box-sizing:border-box;}
        .sidebar h2 {margin-top:0; font-size:1.4rem;}
        .sidebar a {color:white; text-decoration:none; display:block; margin:12px 0; font-weight:600;}
        .sidebar a:hover {color:#a5d6a7;}
        .main {flex:1; overflow-y:auto; padding:30px;}
        .section {margin-bottom:40px; background:white; padding:20px; border-radius:8px; box-shadow:0 2px 6px rgba(0,0,0,0.1);}
        .section h3 {margin-top:0; color:#1b5e20;}
    </style>
</head>
<body>
    <div class="sidebar">
        <h2>🛠️ Admin Portal</h2>
        <p>Welcome, <%= user.getUsername() %></p>
        <a href="#destinations">Manage Destinations</a>
        <a href="#hotels">Manage Hotels</a>
        <a href="#users">Manage Users</a>
        <a href="#bookings">Manage Bookings</a>
        <a href="#" id="adminLogoutBtn">Logout</a>
    </div>
    <div class="main">
        <div id="destinations" class="section">
            <h3>➕ Add New Destination</h3>
            <!-- Re‑use the destination form from admin.jsp -->
            <form action="destinations" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addDestination"/>
                <div style="display:flex; gap:15px; margin-bottom:12px;">
                    <input type="text" name="name" placeholder="Destination Name" required style="flex:1;"/>
                    <input type="text" name="imageUrl" placeholder="Image URL (optional)" style="flex:1;"/>
                    <input type="file" name="imageFile" accept=".jpg,.jpeg" />
                </div>
                <div style="display:flex; gap:15px; margin-bottom:12px;">
                    <select name="ecoScore" required style="flex:1;">
                        <option value="">Eco‑Rating</option>
                        <option value="1">⭐ Poor</option>
                        <option value="2">⭐⭐ Fair</option>
                        <option value="3">⭐⭐⭐ Good</option>
                        <option value="4">⭐⭐⭐⭐ Excellent</option>
                        <option value="5">⭐⭐⭐⭐⭐ Perfect</option>
                    </select>
                    <input type="number" name="basePrice" placeholder="Base Price (₹)" required style="flex:1;"/>
                </div>
                <textarea name="description" placeholder="Description" required style="width:100%; height:80px; margin-bottom:12px;"></textarea>
                <textarea name="mapEmbed" placeholder="Google Maps embed (optional)" style="width:100%; height:60px; margin-bottom:12px;"></textarea>
                <button type="submit" style="padding:10px 20px; background:#2e7d32; color:white; border:none; border-radius:4px;">Publish Destination</button>
            </form>
        </div>
        <div id="hotels" class="section">
            <h3>🏨 Add Nearby Hotel</h3>
            <!-- Placeholder for hotel form – copy from admin.jsp as needed -->
            <p>Hotel management form goes here.</p>
        </div>
        <div id="users" class="section">
            <h3>👥 Registered Users</h3>
            <p>User table placeholder.</p>
        </div>
        <div id="bookings" class="section">
            <h3>📋 All Bookings</h3>
            <p>Bookings table placeholder – you can include the same table markup from admin.jsp.</p>
        </div>
    </div>
    <script src="/js/toast.js"></script>
    <script src="/js/logout.js"></script>
</body>
</html>
