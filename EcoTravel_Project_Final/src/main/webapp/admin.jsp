<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect("admin_login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard - EcoTravel Karnataka</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #1b5e20; color: white; padding: 15px; display:flex; justify-content:space-between; align-items:center; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 1100px; margin: 30px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); overflow-x:auto;}
        table { width: 100%; border-collapse: collapse; margin-top: 20px; margin-bottom: 40px;}
        th, td { padding: 15px; border-bottom: 1px solid #ddd; text-align: left; }
        th { background-color: #2e7d32; color: white; }
        h2 { color: #1b5e20; border-bottom: 2px solid #a5d6a7; padding-bottom: 10px; }
    </style>
</head>
<body>
    <div class="nav">
        <span style="font-size: 1.4em; font-weight: bold;">🌿 EcoTravel Admin Portal</span>
        <div>
            <span>Welcome, <%= user.getUsername() %></span>
            <a href="auth?action=logout">Logout</a>
        </div>
    </div>
    <div class="container">
        
        <div style="background:#f1f8e9; padding:25px; border-radius:8px; margin-bottom:40px; border:2px dashed #a5d6a7;">
            <h2 style="margin-top:0; border:none;">➕ Add New Trip Destination</h2>
            <form action="destinations" method="post" enctype="multipart/form-data">
                <input type="hidden" name="action" value="addDestination">
                <div style="display:flex; justify-content:space-between; margin-bottom:15px;">
                    <input type="text" name="name" placeholder="Destination Name (e.g., Coorg Spice Trails)" required style="width:48%; padding:10px; border:1px solid #ccc; border-radius:4px;">
                    <input type="file" name="imageFile" accept=".jpg, .jpeg, image/jpeg" required title="Please select a JPG image from your computer" style="width:48%; padding:10px; border:1px solid #ccc; border-radius:4px; box-sizing:border-box; background:white;">
                </div>
                <div style="display:flex; justify-content:space-between; margin-bottom:15px;">
                    <input type="number" name="ecoScore" min="1" max="10" placeholder="Eco-Score (1-10)" required style="width:48%; padding:10px; border:1px solid #ccc; border-radius:4px;">
                    <input type="number" name="basePrice" placeholder="Base Trip Price (₹)" required style="width:48%; padding:10px; border:1px solid #ccc; border-radius:4px;">
                </div>
                <textarea name="description" placeholder="Description of the place" required style="width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:4px; box-sizing:border-box;"></textarea>
                <textarea name="mapEmbed" placeholder="Google Maps Embed <iframe...> HTML" required style="width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:4px; box-sizing:border-box;"></textarea>
                <button type="submit" style="padding:12px 25px; background:#2e7d32; color:white; border:none; border-radius:4px; font-weight:bold; cursor:pointer;">Publish Destination</button>
            </form>
            <% if (request.getParameter("msg") != null) { %>
                <div style="color:#2e7d32; font-weight:bold; margin-top:15px;"><%= request.getParameter("msg") %></div>
            <% } %>
        </div>

        </div>

        <h2>Manage Eco-Destinations</h2>
        <table style="width:100%; text-align:left;">
            <tr>
                <th>ID</th>
                <th>Destination Name</th>
                <th>Eco Score</th>
                <th>Base Price</th>
                <th>Actions</th>
            </tr>
            <% 
               com.ecotravel.dao.DestinationDao dDao = new com.ecotravel.dao.DestinationDao();
               request.setAttribute("currentDestinations", dDao.getAllDestinations());
            %>
            <c:forEach var="d" items="${currentDestinations}">
                <tr>
                    <td style="font-weight:bold;">${d.id}</td>
                    <td>${d.name}</td>
                    <td><span style="background:#e8f5e9; padding:2px 6px; border-radius:4px; color:#2e7d32;">${d.ecoScore}/10</span></td>
                    <td>₹${d.basePrice}</td>
                    <td>
                        <a href="destinations?action=edit&id=${d.id}" style="color:white; background:#1976d2; padding:5px 10px; border-radius:4px; text-decoration:none; margin-right:5px; font-weight:normal; font-size: 0.9em;">✏️ Edit</a>
                        <a href="destinations?action=delete&id=${d.id}" onclick="return confirm('WARNING: Are you sure you want to delete this trip and all associated bookings? This cannot be undone!')" style="color:white; background:#d32f2f; padding:5px 10px; border-radius:4px; text-decoration:none; font-weight:normal; font-size: 0.9em;">🗑️ Delete</a>
                    </td>
                </tr>
            </c:forEach>
            <c:if test="${empty currentDestinations}">
                <tr><td colspan="5" style="text-align:center;">No destinations found.</td></tr>
            </c:if>
        </table>

        <h2>Registered System Users</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Username</th>
                <th>Email</th>
                <th>System Role</th>
            </tr>
            <c:forEach var="u" items="${users}">
                <tr>
                    <td>${u.id}</td>
                    <td>${u.username}</td>
                    <td>${u.email}</td>
                    <td><span style="background:#e8f5e9; padding:2px 6px; border-radius:4px;">${u.role}</span></td>
                </tr>
            </c:forEach>
            <c:if test="${empty users}">
                <tr><td colspan="4" style="text-align:center;">No users found.</td></tr>
            </c:if>
        </table>

        <h2>All System Bookings</h2>
        <table>
            <tr>
                <th>Booking ID</th>
                <th>Passenger Info</th>
                <th>Destination</th>
                <th>Payment Paid</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
            <c:forEach var="b" items="${bookings}">
                <tr>
                    <td style="font-weight:bold;">#${b.id}</td>
                    <td>${b.contactName} (${b.contactMobile})</td>
                    <td>${b.destinationName}</td>
                    <td style="color:#d32f2f; font-weight:bold;">₹${b.totalCost}</td>
                    <td style="color:green;font-weight:bold;">${b.status}</td>
                    <td><small>${b.bookingDate}</small></td>
                </tr>
            </c:forEach>
            <c:if test="${empty bookings}">
                <tr><td colspan="6" style="text-align:center;">No bookings found yet.</td></tr>
            </c:if>
        </table>

    </div>
</body>
</html>
