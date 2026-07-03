<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<% if (session.getAttribute("user") == null) { response.sendRedirect("user_login.jsp"); return; }
   com.ecotravel.model.User currentUser = (com.ecotravel.model.User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings – EcoTravel Karnataka</title>
    <meta name="description" content="View and manage your eco-travel bookings on EcoTravel Karnataka.">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: #f0f7f0; color: #222; }

        /* NAV */
        .navbar { background: #1b5e20; padding: 12px 30px; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 100; box-shadow: 0 2px 8px rgba(0,0,0,0.3); }
        .logo-container { color: white; font-size: 1.25rem; font-weight: 800; display: flex; align-items: center; gap: 8px; text-decoration: none; background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.15); padding: 8px 16px; border-radius: 8px; transition: background 0.2s; }
        .logo-container:hover { background: rgba(255,255,255,0.15); }
        .nav-menu { list-style: none; display: flex; gap: 24px; align-items: center; }
        .nav-menu a { color: rgba(255,255,255,0.9); text-decoration: none; font-weight: 600; font-size: 0.95rem; transition: color 0.2s; }
        .nav-menu a:hover { color: #a5d6a7; }
        .btn-logout { font-size: 0.85rem; font-weight: 600; color: #ffab91; text-decoration: none; transition: color 0.2s; }
        .btn-logout:hover { color: #ff8a65; }

        /* PAGE HEADER */
        .page-hero {
            background: linear-gradient(135deg, #1b5e20 0%, #2e7d32 60%, #388e3c 100%);
            padding: 50px 30px;
            text-align: center;
            color: white;
        }
        .page-hero h1 { font-size: 2.4rem; font-weight: 800; margin-bottom: 8px; }
        .page-hero p { font-size: 1.05rem; color: rgba(255,255,255,0.85); }

        /* MAIN CONTENT */
        .main-content { max-width: 1100px; margin: 40px auto; padding: 0 20px 60px; }

        /* ALERT */
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 14px 20px; border-radius: 10px; margin-bottom: 28px; text-align: center; font-weight: 600; font-size: 0.95rem; }

        /* EMPTY STATE */
        .empty-state { text-align: center; padding: 70px 20px; background: white; border-radius: 20px; box-shadow: 0 4px 20px rgba(0,0,0,0.06); }
        .empty-state .empty-icon { font-size: 4rem; margin-bottom: 16px; }
        .empty-state h3 { font-size: 1.5rem; color: #1b5e20; font-weight: 700; margin-bottom: 10px; }
        .empty-state p { color: #666; margin-bottom: 24px; }
        .btn-explore { display: inline-block; background: linear-gradient(135deg, #2e7d32, #1b5e20); color: white; padding: 12px 30px; border-radius: 50px; text-decoration: none; font-weight: 700; font-size: 0.95rem; transition: transform 0.2s, box-shadow 0.2s; box-shadow: 0 4px 12px rgba(46,125,50,0.3); }
        .btn-explore:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(46,125,50,0.4); }

        /* BOOKINGS GRID */
        .bookings-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(320px, 1fr)); gap: 24px; }

        .booking-card {
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07);
            overflow: hidden;
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex;
            flex-direction: column;
        }
        .booking-card:hover { transform: translateY(-5px); box-shadow: 0 12px 35px rgba(0,0,0,0.12); }

        .booking-card-header {
            background: linear-gradient(135deg, #1b5e20, #2e7d32);
            padding: 16px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .booking-id { color: rgba(255,255,255,0.7); font-size: 0.8rem; font-weight: 600; }
        .booking-type-badge { background: rgba(255,255,255,0.2); color: white; padding: 4px 12px; border-radius: 20px; font-size: 0.78rem; font-weight: 700; text-transform: uppercase; letter-spacing: 0.5px; }

        .booking-card-body { padding: 20px; flex: 1; }
        .booking-title { font-size: 1.15rem; font-weight: 700; color: #1b5e20; margin-bottom: 12px; }
        .booking-detail { display: flex; align-items: flex-start; gap: 8px; font-size: 0.88rem; color: #555; margin-bottom: 8px; line-height: 1.4; }
        .booking-detail .detail-icon { font-size: 1rem; flex-shrink: 0; margin-top: 1px; }

        .status-badge { display: inline-block; padding: 4px 14px; border-radius: 20px; font-size: 0.78rem; font-weight: 700; margin-top: 12px; }
        .status-confirmed { background: #e8f5e9; color: #2e7d32; }
        .status-pending { background: #fff8e1; color: #f57f17; }
        .status-cancelled { background: #fce4ec; color: #c62828; }

        .booking-cost { font-size: 1.4rem; font-weight: 800; color: #1b5e20; margin-top: 14px; }
        .booking-cost span { font-size: 0.85rem; color: #888; font-weight: 400; }

        .booking-card-footer { padding: 14px 20px; border-top: 1px solid #f0f0f0; display: flex; gap: 10px; flex-wrap: wrap; }

        .action-btn { padding: 8px 16px; border-radius: 8px; font-size: 0.82rem; font-weight: 700; text-decoration: none; border: none; cursor: pointer; transition: all 0.2s; display: inline-block; font-family: 'Outfit', sans-serif; }
        .btn-modify { background: #e8f5e9; color: #1b5e20; }
        .btn-modify:hover { background: #c8e6c9; }
        .btn-whatsapp { background: #25D366; color: white; }
        .btn-whatsapp:hover { background: #1ebe5a; }
        .btn-cancel { background: #fce4ec; color: #c62828; }
        .btn-cancel:hover { background: #f8bbd0; }

        footer { background: #1b5e20; color: rgba(255,255,255,0.8); text-align: center; padding: 24px; margin-top: 0; font-size: 0.9rem; }
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="index.jsp" class="logo-container">🌿 EcoTravel</a>
        <ul class="nav-menu">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="destinations?action=hotels">Hotels</a></li>
            <li><a href="index.jsp#tours">Green Tours</a></li>
            <li><a href="profile.jsp">My Profile</a></li>
        </ul>
        <div style="display:flex; align-items:center; gap:16px;">
            <span style="color:white; font-weight:600; font-size:0.9rem;">Hi, <%= currentUser.getUsername() %> 👋</span>
            <a href="auth?action=logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <!-- PAGE HERO -->
    <div class="page-hero">
        <h1>🗒️ My Eco-Bookings</h1>
        <p>Your sustainable travel history, all in one place.</p>
    </div>

    <!-- MAIN CONTENT -->
    <div class="main-content">
        <c:if test="${not empty param.msg}">
            <div class="alert-success">✅ <c:out value="${param.msg}" escapeXml="false"/></div>
        </c:if>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="empty-state">
                    <div class="empty-icon">🌿</div>
                    <h3>No Eco-Trips Yet!</h3>
                    <p>You haven't made any bookings yet. Start exploring our eco-friendly destinations!</p>
                    <a href="index.jsp#tours" class="btn-explore">🌍 Explore Destinations</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bookings-grid">
                    <c:forEach var="b" items="${bookings}">
                        <div class="booking-card">
                            <div class="booking-card-header">
                                <span class="booking-id">Booking #${b.id}</span>
                                <span class="booking-type-badge">
                                    <c:choose>
                                        <c:when test="${b.bookingType == 'hotel'}">🏨 Hotel</c:when>
                                        <c:otherwise>🌿 Tour</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="booking-card-body">
                                <div class="booking-title">
                                    <c:choose>
                                        <c:when test="${b.bookingType == 'hotel'}">${b.hotelName}</c:when>
                                        <c:otherwise>${b.destinationName}</c:otherwise>
                                    </c:choose>
                                </div>

                                <c:if test="${b.bookingType == 'hotel'}">
                                    <div class="booking-detail">
                                        <span class="detail-icon">📅</span>
                                        <span>Check-in: <strong>${b.checkIn}</strong> &nbsp;→&nbsp; Check-out: <strong>${b.checkOut}</strong></span>
                                    </div>
                                </c:if>
                                <c:if test="${b.bookingType != 'hotel'}">
                                    <div class="booking-detail">
                                        <span class="detail-icon">📍</span>
                                        <span>Destination: <strong>${b.destinationName}</strong></span>
                                    </div>
                                </c:if>

                                <div>
                                    <c:choose>
                                        <c:when test="${b.status == 'CONFIRMED'}">
                                            <span class="status-badge status-confirmed">✅ Confirmed</span>
                                        </c:when>
                                        <c:when test="${b.status == 'CANCELLED'}">
                                            <span class="status-badge status-cancelled">❌ Cancelled</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="status-badge status-pending">⏳ ${b.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                                <div class="booking-cost">₹${b.totalCost} <span>/ total</span></div>
                            </div>
                            <div class="booking-card-footer">
                                <a class="action-btn btn-modify" href="bookings?action=edit&id=${b.id}">✏️ Modify</a>
                                <a class="action-btn btn-whatsapp"
                                   href="https://wa.me/91${b.contactMobile}?text=EcoTravel%20Booking%20%23${b.id}%20-%20Status%3A%20${b.status}"
                                   target="_blank">💬 WhatsApp</a>
                                <form action="bookings" method="post" style="display:inline; margin:0;">
                                    <input type="hidden" name="action" value="cancel"/>
                                    <input type="hidden" name="bookingId" value="${b.id}"/>
                                    <button class="action-btn btn-cancel" type="submit"
                                            onclick="return confirm('Cancel this booking?');">🗑️ Cancel</button>
                                </form>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <footer>
        <p>© 2026 EcoTravel Karnataka. Promoting Sustainable Tourism. 🌿</p>
    </footer>
</body>
</html>
