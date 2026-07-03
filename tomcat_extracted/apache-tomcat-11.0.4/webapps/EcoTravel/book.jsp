<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
    String ctxPath = request.getContextPath();
    // Build correct image URL
    String imgUrl = "${destination.imageUrl}";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${destination.name} - EcoTravel Karnataka</title>
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: 'Outfit', sans-serif; background: #f0f7f0; color: #222; }

        /* NAV */
        .navbar { background: #1b5e20; padding: 14px 30px; display: flex; justify-content: space-between; align-items: center; position: sticky; top: 0; z-index: 100; }
        .nav-brand { color: white; font-size: 1.2rem; font-weight: 800; text-decoration: none; }
        .nav-back { color: rgba(255,255,255,0.85); text-decoration: none; font-weight: 600; font-size: 0.95rem; }
        .nav-back:hover { color: white; }

        /* HERO */
        .hero-wrap { position: relative; height: 420px; overflow: hidden; }
        .hero-img {
            width: 100%; height: 100%; object-fit: cover; display: block;
            transition: transform 0.6s ease;
        }
        .hero-overlay {
            position: absolute; inset: 0;
            background: linear-gradient(to bottom, rgba(0,0,0,0.1) 0%, rgba(0,0,0,0.65) 100%);
            display: flex; align-items: flex-end; padding: 40px;
        }
        .hero-title { color: white; font-size: 2.8rem; font-weight: 800; text-shadow: 0 2px 10px rgba(0,0,0,0.5); }

        /* CONTENT */
        .page-content { max-width: 1100px; margin: 0 auto; padding: 40px 20px; }

        /* INFO GRID */
        .info-grid { display: grid; grid-template-columns: 1fr 340px; gap: 30px; }

        /* MAIN COLUMN */
        .main-col {}
        .section-card {
            background: white; border-radius: 16px; padding: 30px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.07); margin-bottom: 25px;
        }
        .section-card h2 { color: #1b5e20; font-size: 1.4rem; font-weight: 700; margin-bottom: 15px; border-bottom: 2px solid #e8f5e9; padding-bottom: 10px; }

        .desc-text { font-size: 1.05rem; line-height: 1.75; color: #444; }

        /* Highlights */
        .highlights { display: flex; gap: 15px; flex-wrap: wrap; margin-top: 15px; }
        .highlight-chip {
            background: #e8f5e9; color: #1b5e20; padding: 8px 18px;
            border-radius: 50px; font-weight: 600; font-size: 0.95rem;
        }

        .map-wrap { border-radius: 12px; overflow: hidden; }
        .map-wrap iframe { width: 100%; height: 300px; border: none; display: block; }

        /* SIDEBAR */
        .sidebar-col {}
        .booking-card {
            background: white; border-radius: 16px; padding: 28px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.1); position: sticky; top: 80px;
        }
        .booking-card h3 { color: #1b5e20; font-size: 1.2rem; font-weight: 700; margin-bottom: 20px; }
        .price-row { display: flex; align-items: center; justify-content: space-between; margin-bottom: 20px; }
        .price-big { font-size: 2rem; font-weight: 800; color: #1b5e20; }
        .price-label { color: #888; font-size: 0.85rem; }
        .eco-row { display: flex; align-items: center; gap: 10px; margin-bottom: 20px; }
        .eco-label { font-weight: 600; color: #555; }
        .stars { color: #fbc02d; font-size: 1.2rem; }

        .divider { border: none; border-top: 1px solid #e8f5e9; margin: 20px 0; }

        .btn-book-main {
            display: block; width: 100%; text-align: center;
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white; border: none; padding: 16px;
            border-radius: 12px; font-size: 1.1rem; font-weight: 700;
            cursor: pointer; text-decoration: none;
            box-shadow: 0 6px 20px rgba(46,125,50,0.3);
            transition: transform 0.2s, box-shadow 0.2s;
        }
        .btn-book-main:hover { transform: translateY(-2px); box-shadow: 0 10px 28px rgba(46,125,50,0.4); }

        .login-note { text-align: center; color: #888; font-size: 0.88rem; margin-top: 12px; }
        .login-note a { color: #2e7d32; text-decoration: none; font-weight: 600; }

        /* HOTELS */
        .hotels-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 20px; }
        .hotel-card {
            background: white; border-radius: 16px; overflow: hidden;
            box-shadow: 0 4px 15px rgba(0,0,0,0.07); transition: transform 0.3s;
        }
        .hotel-card:hover { transform: translateY(-4px); }
        .hotel-card img { width: 100%; height: 180px; object-fit: cover; display: block; }
        .hotel-body { padding: 18px; }
        .hotel-body h4 { color: #1b5e20; font-size: 1.1rem; font-weight: 700; margin-bottom: 8px; }
        .hotel-body p { color: #666; font-size: 0.9rem; line-height: 1.5; margin-bottom: 12px; white-space: pre-line; }
        .hotel-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 14px; }
        .hotel-stars { color: #fbc02d; font-size: 0.95rem; font-weight: 700; }
        .hotel-price { color: #2e7d32; font-weight: 700; font-size: 1rem; }
        .btn-hotel {
            display: block; width: 100%; text-align: center;
            background: #2e7d32; color: white; padding: 10px;
            border-radius: 8px; text-decoration: none; font-weight: 700;
            transition: background 0.2s;
        }
        .btn-hotel:hover { background: #1b5e20; }
        .btn-hotel-secondary { margin-bottom: 18px; background: #e8f5e9; color: #1b5e20; border: 1px solid #a5d6a7; }
        .btn-hotel-secondary:hover { background: #c8e6c9; }

        .no-hotels { text-align: center; color: #888; padding: 40px; background: white; border-radius: 12px; }

        @media (max-width: 768px) {
            .info-grid { grid-template-columns: 1fr; }
            .hero-title { font-size: 1.8rem; }
            .booking-card { position: static; }
        }
    </style>
</head>
<body>

    <nav class="navbar">
        <a href="index.jsp" class="nav-brand">🌿 EcoTravel Karnataka</a>
        <a href="javascript:history.back()" class="nav-back">← Back</a>
    </nav>

    <%
        // Resolve image URL properly
        String destImg = (String) ((com.ecotravel.model.Destination) request.getAttribute("destination") != null
            ? ((com.ecotravel.model.Destination) request.getAttribute("destination")).getImageUrl() : null);
        String resolvedImg;
        if (destImg != null && (destImg.startsWith("http://") || destImg.startsWith("https://"))) {
            resolvedImg = destImg;
        } else if (destImg != null && !destImg.isEmpty()) {
            resolvedImg = ctxPath + "/" + destImg;
        } else {
            resolvedImg = "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=1200&q=80";
        }
    %>

    <!-- HERO SECTION -->
    <div class="hero-wrap">
        <img src="<%= resolvedImg %>" alt="${destination.name}" class="hero-img"
             onerror="this.src='https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=1200&q=80'">
        <div class="hero-overlay">
            <h1 class="hero-title">${destination.name}</h1>
        </div>
    </div>

    <div class="page-content">
        <div class="info-grid">

            <!-- MAIN COLUMN -->
            <div class="main-col">

                <!-- About the Place -->
                <div class="section-card">
                    <h2>📍 About This Destination</h2>
                    <p class="desc-text">${destination.description}</p>
                    <div class="highlights">
                        <span class="highlight-chip">🌿 Eco-Friendly</span>
                        <span class="highlight-chip">🏕️ Nature Tourism</span>
                        <span class="highlight-chip">♻️ Zero-Plastic Zone</span>
                        <span class="highlight-chip">🌍 Karnataka</span>
                    </div>
                </div>

                <!-- Map Section -->
                <c:if test="${not empty destination.mapEmbed}">
                <div class="section-card">
                    <h2>🗺️ Location Map</h2>
                    <div class="map-wrap">${destination.mapEmbed}</div>
                </div>
                </c:if>

                <!-- Nearby Hotels -->
                <div class="section-card">
                    <h2>🏨 Eco-Friendly Hotels Nearby</h2>
                    <a href="destinations?action=hotels&destinationId=${destination.id}" class="btn-hotel btn-hotel-secondary">View Hotel Details</a>
                    <c:choose>
                        <c:when test="${not empty hotels}">
                            <div class="hotels-grid">
                                <c:forEach var="h" items="${hotels}">
                                    <div class="hotel-card">
                                        <img src="${h.imageUrl}" alt="${h.name}"
                                             onerror="this.src='https://images.unsplash.com/photo-1551882547-ff40c63fe5fa?auto=format&fit=crop&w=400&q=80'">
                                        <div class="hotel-body">
                                            <h4>${h.name}</h4>
                                            <p>${h.description}</p>
                                            <div class="hotel-meta">
                                                <span class="hotel-stars">
                                                    <c:forEach begin="1" end="${h.ecoRating}">⭐</c:forEach> Eco
                                                </span>
                                                <span class="hotel-price">₹${h.pricePerNight}/night</span>
                                            </div>
                                            <% if (user != null) { %>
                                                <a href="hotel_booking.jsp?hotelId=${h.id}" class="btn-hotel">Book Hotel Stay</a>
                                            <% } else { %>
                                                <a href="user_login.jsp?redirect=hotel_booking.jsp?hotelId=${h.id}" class="btn-hotel">Login to Book</a>
                                            <% } %>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="no-hotels">No eco hotels listed for this destination yet.</div>
                        </c:otherwise>
                    </c:choose>
                </div>

            </div><!-- /main-col -->

            <!-- SIDEBAR: BOOKING CARD -->
            <div class="sidebar-col">
                <div class="booking-card">
                    <h3>Plan Your Trip</h3>
                    <div class="price-row">
                        <div>
                            <div class="price-big">₹${destination.basePrice}</div>
                            <div class="price-label">per trip / person</div>
                        </div>
                    </div>
                    <div class="eco-row">
                        <span class="eco-label">Eco Rating:</span>
                        <span class="stars">
                            <c:forEach begin="1" end="${destination.ecoScore}">⭐</c:forEach>
                        </span>
                    </div>
                    <hr class="divider">
                    <% if (user != null) { %>
                        <a href="booking_form.jsp?destId=${destination.id}&bookingType=destination" class="btn-book-main">
                            🌿 Book This Tour Now
                        </a>
                        <p class="login-note">Logged in as <strong><%= user.getUsername() %></strong></p>
                    <% } else { %>
                        <a href="user_login.jsp?redirect=booking_form.jsp%3FdestId%3D${destination.id}%26bookingType%3Ddestination" class="btn-book-main">
                            🌿 Login & Book Now
                        </a>
                        <p class="login-note">
                            <a href="user_login.jsp">Login</a> or
                            <a href="user_login.jsp?action=register">create an account</a> to book
                        </p>
                    <% } %>
                </div>
            </div>

        </div><!-- /info-grid -->
    </div>

</body>
</html>
