<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User currentUser = (com.ecotravel.model.User) session.getAttribute("user");
    String ctxPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eco-Friendly Hotels – EcoTravel Karnataka</title>
    <meta name="description" content="Browse and book eco-friendly, sustainable hotels across Karnataka's top green destinations.">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: #f0f7f0; color: #222; }

        /* ── NAVBAR ── */
        .navbar {
            background: #1b5e20;
            padding: 12px 30px;
            display: flex; justify-content: space-between; align-items: center;
            position: sticky; top: 0; z-index: 100;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }
        .logo-container {
            color: white; font-size: 1.25rem; font-weight: 800;
            display: flex; align-items: center; gap: 8px;
            text-decoration: none;
            background: rgba(255,255,255,0.08); border: 1px solid rgba(255,255,255,0.15);
            padding: 8px 16px; border-radius: 8px; transition: background 0.2s;
        }
        .logo-container:hover { background: rgba(255,255,255,0.15); }
        .nav-menu { list-style: none; display: flex; gap: 28px; align-items: center; }
        .nav-menu a { color: rgba(255,255,255,0.9); text-decoration: none; font-weight: 600; font-size: 0.95rem; transition: color 0.2s; }
        .nav-menu a:hover { color: #a5d6a7; }
        .nav-actions { display: flex; gap: 14px; align-items: center; }
        .btn-outline { color: rgba(255,255,255,0.9); text-decoration: none; font-weight: 600; font-size: 0.9rem; padding: 7px 16px; border: 1px solid rgba(255,255,255,0.4); border-radius: 20px; transition: all 0.2s; }
        .btn-outline:hover { background: rgba(255,255,255,0.1); }
        .btn-signup { background: white; color: #1b5e20 !important; padding: 8px 18px; border-radius: 20px; font-weight: 700; text-decoration: none; font-size: 0.9rem; transition: background 0.2s; }
        .btn-signup:hover { background: #e8f5e9; }
        .btn-logout { font-size: 0.85rem; font-weight: 600; color: #ffab91; text-decoration: none; }
        .btn-logout:hover { color: #ff8a65; }
        .user-greeting { font-size: 0.9rem; font-weight: 600; color: white; }

        /* ── HERO BANNER ── */
        .page-hero {
            background: linear-gradient(rgba(0,70,0,0.72), rgba(0,50,0,0.82)),
                        url('images/eco_resort_bg.png') center/cover no-repeat;
            min-height: 340px;
            display: flex; flex-direction: column;
            align-items: center; justify-content: center;
            text-align: center; padding: 60px 20px;
            color: white;
        }
        .page-hero h1 { font-size: 2.8rem; font-weight: 800; text-shadow: 0 2px 8px rgba(0,0,0,0.4); margin-bottom: 10px; }
        .page-hero h1 span { color: #a5d6a7; }
        .page-hero p { font-size: 1.1rem; color: rgba(255,255,255,0.88); max-width: 560px; line-height: 1.6; }

        /* ── DESTINATION BREADCRUMB ── */
        .breadcrumb-bar {
            max-width: 1200px; margin: 20px auto 0; padding: 0 20px;
            font-size: 0.88rem; color: #666;
        }
        .breadcrumb-bar a { color: #2e7d32; text-decoration: none; font-weight: 600; }
        .breadcrumb-bar a:hover { text-decoration: underline; }

        /* ── GRID ── */
        .container { max-width: 1200px; margin: 30px auto 60px; padding: 0 20px; }
        .section-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 28px; }
        .section-title { font-size: 1.6rem; font-weight: 800; color: #1b5e20; }
        .hotel-count { background: #e8f5e9; color: #2e7d32; padding: 5px 14px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; }

        .hotel-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(340px, 1fr)); gap: 28px; }

        /* ── HOTEL CARD ── */
        .hotel-card {
            background: white; border-radius: 18px; overflow: hidden;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
            transition: transform 0.3s, box-shadow 0.3s;
            display: flex; flex-direction: column;
        }
        .hotel-card:hover { transform: translateY(-7px); box-shadow: 0 16px 40px rgba(0,0,0,0.14); }

        .hotel-img-wrapper { position: relative; height: 230px; overflow: hidden; }
        .hotel-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.4s; }
        .hotel-card:hover .hotel-img { transform: scale(1.05); }

        .eco-badge {
            position: absolute; top: 14px; left: 14px;
            background: #1b5e20; color: white;
            padding: 5px 12px; border-radius: 20px;
            font-size: 0.75rem; font-weight: 700;
            display: flex; align-items: center; gap: 5px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.25);
        }
        .price-tag {
            position: absolute; bottom: 14px; right: 14px;
            background: rgba(0,0,0,0.72); color: white;
            padding: 6px 14px; border-radius: 20px;
            font-size: 1rem; font-weight: 800;
        }

        .hotel-info { padding: 22px; flex: 1; display: flex; flex-direction: column; }
        .hotel-title { font-size: 1.2rem; font-weight: 800; color: #1b5e20; margin-bottom: 6px; }

        .eco-stars { color: #fbc02d; font-size: 0.95rem; margin-bottom: 10px; display: flex; align-items: center; gap: 4px; }
        .eco-stars span { color: #888; font-size: 0.82rem; font-weight: 500; }

        .hotel-desc { color: #666; font-size: 0.9rem; line-height: 1.6; flex: 1; margin-bottom: 18px; }

        .hotel-amenities { display: flex; flex-wrap: wrap; gap: 6px; margin-bottom: 16px; }
        .amenity { background: #f0f7f0; color: #2e7d32; padding: 4px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; }

        .btn-reserve {
            display: block; width: 100%; text-align: center;
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white; padding: 13px;
            border-radius: 10px; font-size: 1rem; font-weight: 700;
            text-decoration: none; transition: opacity 0.2s, transform 0.2s;
            box-shadow: 0 3px 12px rgba(46,125,50,0.3);
        }
        .btn-reserve:hover { opacity: 0.9; transform: translateY(-2px); }

        /* ── EMPTY STATE ── */
        .empty-state { text-align: center; padding: 80px 20px; grid-column: 1 / -1; }
        .empty-state .empty-icon { font-size: 4rem; margin-bottom: 16px; }
        .empty-state h3 { font-size: 1.5rem; color: #1b5e20; font-weight: 700; margin-bottom: 10px; }
        .empty-state p { color: #777; margin-bottom: 24px; }

        /* ── SUCCESS BANNER ── */
        .success-banner {
            background: linear-gradient(135deg, #e8f5e9, #f1f8f1);
            border: 1px solid #c8e6c9; border-radius: 16px;
            padding: 24px 30px; margin-bottom: 30px;
            text-align: center;
        }
        .success-banner h3 { color: #1b5e20; font-size: 1.3rem; font-weight: 800; margin-bottom: 8px; }
        .success-banner p { color: #555; font-size: 0.95rem; line-height: 1.6; }
        .success-banner .detail-row { display: inline-flex; gap: 20px; margin-top: 12px; flex-wrap: wrap; justify-content: center; }
        .detail-chip { background: white; border: 1px solid #c8e6c9; padding: 6px 16px; border-radius: 20px; font-size: 0.85rem; font-weight: 700; color: #2e7d32; }

        /* ── FOOTER ── */
        footer { background: #1b5e20; color: rgba(255,255,255,0.8); text-align: center; padding: 24px; font-size: 0.9rem; }
    </style>
</head>
<body>

<!-- ── NAVBAR ── -->
<nav class="navbar">
    <a href="<%= ctxPath %>/index.jsp" class="logo-container">🌿 EcoTravel</a>
    <ul class="nav-menu">
        <li><a href="<%= ctxPath %>/index.jsp">Home</a></li>
        <li><a href="<%= ctxPath %>/destinations?action=hotels">Hotels</a></li>
        <li><a href="<%= ctxPath %>/index.jsp#tours">Green Tours</a></li>
        <li><a href="<%= ctxPath %>/index.jsp#about">About Us</a></li>
    </ul>
    <div class="nav-actions">
        <% if (currentUser == null) { %>
            <a href="<%= ctxPath %>/user_login.jsp" class="btn-outline">Login</a>
            <a href="<%= ctxPath %>/user_login.jsp?action=register" class="btn-signup">Sign Up</a>
        <% } else { %>
            <a href="<%= ctxPath %>/my_bookings.jsp" class="btn-outline">My Bookings</a>
            <span class="user-greeting">Hi, <%= currentUser.getUsername() %> 👋</span>
            <a href="<%= ctxPath %>/auth?action=logout" class="btn-logout">Logout</a>
        <% } %>
    </div>
</nav>

<!-- ── HERO BANNER ── -->
<div class="page-hero">
    <h1>
        <c:choose>
            <c:when test="${not empty destination}"><span>${destination.name}</span> Hotels</c:when>
            <c:otherwise>🏨 Eco-Friendly <span>Hotels</span></c:otherwise>
        </c:choose>
    </h1>
    <p>Stay close to nature, responsibly. Every stay supports local ecosystems and green living.</p>
</div>

<!-- ── BREADCRUMB ── -->
<div class="breadcrumb-bar">
    <a href="<%= ctxPath %>/index.jsp">Home</a> &rsaquo;
    <c:choose>
        <c:when test="${not empty destination}">
            <a href="<%= ctxPath %>/destinations?action=hotels">Hotels</a> &rsaquo; ${destination.name}
        </c:when>
        <c:otherwise>Hotels</c:otherwise>
    </c:choose>
</div>

<!-- ── MAIN CONTENT ── -->
<div class="container">

    <!-- SUCCESS CONFIRMATION -->
    <c:if test="${not empty param.bookingType}">
        <div class="success-banner">
            <h3>✅ Booking Confirmed!</h3>
            <p>Your stay at <strong>${param.hotelName}</strong> in <strong>${param.destinationName}</strong> has been confirmed.<br>Thank you for choosing a sustainable adventure with EcoTravel!</p>
            <div class="detail-row">
                <span class="detail-chip">📊 Eco-Score: High</span>
                <span class="detail-chip">🌿 Green Certified</span>
                <span class="detail-chip">✅ Status: Confirmed</span>
            </div>
        </div>
    </c:if>

    <!-- SECTION HEADER -->
    <div class="section-header">
        <h2 class="section-title">
            <c:choose>
                <c:when test="${not empty destination}">Hotels in ${destination.name}</c:when>
                <c:otherwise>All Eco Hotels</c:otherwise>
            </c:choose>
        </h2>
        <c:if test="${not empty hotels}">
            <span class="hotel-count">${hotels.size()} hotels found</span>
        </c:if>
    </div>

    <!-- HOTEL GRID -->
    <div class="hotel-grid">
        <c:choose>
            <c:when test="${not empty hotels}">
                <c:forEach var="h" items="${hotels}">
                    <div class="hotel-card">
                        <div class="hotel-img-wrapper">
                            <img
                                src="${h.imageUrl}"
                                alt="${h.name}"
                                class="hotel-img"
                                onerror="this.onerror=null;this.src='https://images.unsplash.com/photo-1520250497591-112f2f40a3f4?auto=format&fit=crop&w=800&q=80';">
                            <div class="eco-badge">🌿 Eco Certified</div>
                            <div class="price-tag">₹${h.pricePerNight}<small style="font-size:0.65rem;opacity:0.8">/night</small></div>
                        </div>
                        <div class="hotel-info">
                            <div class="hotel-title">${h.name}</div>
                            <div class="eco-stars">
                                <c:forEach begin="1" end="${h.ecoRating}">⭐</c:forEach>
                                <span>Eco Rating</span>
                            </div>
                            <p class="hotel-desc">${h.description}</p>
                            <div class="hotel-amenities">
                                <span class="amenity">🌱 Eco-Friendly</span>
                                <span class="amenity">♻️ Zero-Waste</span>
                                <span class="amenity">💧 Water Saving</span>
                                <span class="amenity">🌞 Solar Power</span>
                            </div>
                            <a href="<%= ctxPath %>/hotel_booking.jsp?hotelId=${h.id}" class="btn-reserve">🏨 Reserve Now</a>
                        </div>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-icon">🏨</div>
                    <h3>No Hotels Available Yet</h3>
                    <p>No hotels found for this destination. Check back soon or explore other green locations!</p>
                    <a href="<%= ctxPath %>/index.jsp#tours" style="display:inline-block; background:linear-gradient(135deg,#2e7d32,#1b5e20); color:white; padding:12px 28px; border-radius:50px; text-decoration:none; font-weight:700; margin-top:10px;">🌿 Explore Destinations</a>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<footer>
    <p>© 2026 EcoTravel Karnataka. Promoting Sustainable Tourism. 🌿</p>
</footer>

</body>
</html>