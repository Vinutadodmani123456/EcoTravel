<%@ page import="com.ecotravel.dao.DestinationDao" %>
    <%@ page import="com.ecotravel.model.Destination" %>
        <%@ page import="java.util.List" %>
            <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                <% DestinationDao destDao=new DestinationDao(); List<Destination> topDestinations =
                    destDao.getAllDestinations();
                    com.ecotravel.model.User currentUser = (com.ecotravel.model.User) session.getAttribute("user");
                    String ctxPath = request.getContextPath();
                    %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="UTF-8">
                        <meta name="viewport" content="width=device-width, initial-scale=1.0">
                        <title>EcoTravel | Green Tour Planning Portal - Karnataka</title>
                        <meta name="description"
                            content="Explore eco-friendly destinations in Karnataka. Book sustainable tours and green hotel stays with EcoTravel.">
                        <link rel="stylesheet" href="style.css">
                        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;800&display=swap"
                            rel="stylesheet">
                        <style>
                            * {
                                box-sizing: border-box;
                                margin: 0;
                                padding: 0;
                            }

                            body {
                                font-family: 'Outfit', sans-serif;
                                background: #f0f7f0;
                                color: #222;
                            }

                            /* NAV */
                            .navbar {
                                background: #1b5e20;
                                padding: 12px 30px;
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                position: sticky;
                                top: 0;
                                z-index: 100;
                                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.3);
                            }

                            .logo-container {
                                background: rgba(255, 255, 255, 0.08);
                                border: 1px solid rgba(255, 255, 255, 0.15);
                                padding: 8px 16px;
                                border-radius: 8px;
                                color: white;
                                font-size: 1.25rem;
                                font-weight: 800;
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                text-decoration: none;
                                transition: background 0.2s;
                            }

                            .logo-container:hover {
                                background: rgba(255, 255, 255, 0.12);
                            }

                            .nav-menu {
                                list-style: none;
                                display: flex;
                                gap: 30px;
                                align-items: center;
                                margin: 0;
                                padding: 0;
                            }

                            .nav-menu a {
                                color: rgba(255, 255, 255, 0.9);
                                text-decoration: none;
                                font-weight: 600;
                                font-size: 0.95rem;
                                transition: color 0.2s;
                            }

                            .nav-menu a:hover {
                                color: #a5d6a7;
                            }

                            .nav-actions {
                                display: flex;
                                gap: 20px;
                                align-items: center;
                            }

                            .nav-link-btn {
                                color: rgba(255, 255, 255, 0.9);
                                text-decoration: none;
                                font-weight: 600;
                                font-size: 0.95rem;
                                transition: color 0.2s;
                            }

                            .nav-link-btn:hover {
                                color: #a5d6a7;
                            }

                            .btn-signup {
                                background: white;
                                color: #1b5e20 !important;
                                padding: 8px 18px;
                                border-radius: 20px;
                                font-weight: 700;
                                text-decoration: none;
                                font-size: 0.9rem;
                                transition: background 0.2s;
                            }

                            .btn-signup:hover {
                                background: #e8f5e9;
                            }

                            .nav-link-admin {
                                font-size: 0.8rem;
                                color: rgba(255, 255, 255, 0.6);
                                text-decoration: none;
                                transition: color 0.2s;
                            }

                            .nav-link-admin:hover {
                                color: white;
                            }

                            .user-profile {
                                display: flex;
                                align-items: center;
                                gap: 10px;
                                background: rgba(255, 255, 255, 0.1);
                                border: 1px solid rgba(255, 255, 255, 0.2);
                                padding: 6px 14px;
                                border-radius: 20px;
                                text-decoration: none;
                            }

                            .user-greeting {
                                font-size: 0.9rem;
                                font-weight: 600;
                                color: white;
                            }

                            .avatar {
                                width: 28px;
                                height: 28px;
                                border-radius: 50%;
                                object-fit: cover;
                                border: 1px solid white;
                            }

                            .btn-logout {
                                font-size: 0.85rem;
                                font-weight: 600;
                                color: #ffab91;
                                text-decoration: none;
                                transition: color 0.2s;
                            }

                            .btn-logout:hover {
                                color: #ff8a65;
                            }

                            /* HERO */
                            .hero {
                                background: linear-gradient(rgba(0, 80, 0, 0.7), rgba(0, 70, 0, 0.8)), url('https://images.unsplash.com/photo-1501854140801-50d01698950b?auto=format&fit=crop&w=1920&q=80') center/cover no-repeat;
                                min-height: 500px;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                                text-align: center;
                                padding: 60px 20px;
                            }

                            .hero-content {
                                max-width: 700px;
                                display: flex;
                                flex-direction: column;
                                align-items: center;
                                gap: 20px;
                                text-align: center;
                            }

                            .greeting {
                                font-size: 1.4rem;
                                color: #a5d6a7;
                                font-weight: 600;
                            }

                            .hero-img {
                                width: 120px;
                                height: auto;
                                border-radius: 50%;
                                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.3);
                            }

                            .hero-content h1 {
                                font-size: 3rem;
                                font-weight: 800;
                                color: white;
                                line-height: 1.2;
                                margin-bottom: 16px;
                                text-shadow: 0 2px 8px rgba(0, 0, 0, 0.4);
                            }

                            .hero-content h1 span {
                                color: #a5d6a7;
                            }

                            .hero-content p {
                                font-size: 1.15rem;
                                color: rgba(255, 255, 255, 0.9);
                                margin-bottom: 30px;
                                line-height: 1.6;
                            }

                            .btn-hero {
                                display: inline-block;
                                background: #fbc02d;
                                color: #1b2000;
                                padding: 14px 36px;
                                border-radius: 50px;
                                font-size: 1.05rem;
                                font-weight: 800;
                                text-decoration: none;
                                transition: transform 0.2s, box-shadow 0.2s;
                                box-shadow: 0 4px 15px rgba(251, 192, 45, 0.5);
                            }

                            .btn-hero:hover {
                                transform: translateY(-3px);
                                box-shadow: 0 8px 25px rgba(251, 192, 45, 0.6);
                            }

                            /* TOURS SECTION */
                            .tours-section {
                                max-width: 1300px;
                                margin: 50px auto;
                                padding: 0 20px;
                            }

                            .section-title {
                                text-align: center;
                                font-size: 2rem;
                                font-weight: 800;
                                color: #1b5e20;
                                margin-bottom: 8px;
                            }

                            .section-sub {
                                text-align: center;
                                color: #666;
                                font-size: 1rem;
                                margin-bottom: 40px;
                            }

                            .tour-grid {
                                display: grid;
                                grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
                                gap: 28px;
                            }

                            .tour-card {
                                background: white;
                                border-radius: 16px;
                                overflow: hidden;
                                box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
                                transition: transform 0.3s, box-shadow 0.3s;
                                display: flex;
                                flex-direction: column;
                            }

                            .tour-card:hover {
                                transform: translateY(-6px);
                                box-shadow: 0 12px 35px rgba(0, 0, 0, 0.15);
                            }

                            .tour-image {
                                width: 100%;
                                height: 220px;
                                object-fit: cover;
                                display: block;
                            }

                            .tour-info {
                                padding: 20px;
                                flex: 1;
                                display: flex;
                                flex-direction: column;
                            }

                            .tour-info h3 {
                                font-size: 1.25rem;
                                font-weight: 700;
                                color: #1b5e20;
                                margin-bottom: 8px;
                            }

                            .tour-info p {
                                color: #666;
                                font-size: 0.9rem;
                                line-height: 1.5;
                                flex: 1;
                                margin-bottom: 15px;
                            }

                            .tour-meta {
                                display: flex;
                                justify-content: space-between;
                                align-items: center;
                                margin-bottom: 15px;
                            }

                            .eco-stars {
                                color: #fbc02d;
                                font-size: 1rem;
                                font-weight: 700;
                            }

                            .price {
                                background: #e8f5e9;
                                color: #2e7d32;
                                padding: 4px 12px;
                                border-radius: 20px;
                                font-size: 0.95rem;
                                font-weight: 700;
                            }

                            .btn-book {
                                display: block;
                                width: 100%;
                                text-align: center;
                                background: linear-gradient(135deg, #2e7d32, #1b5e20);
                                color: white;
                                border: none;
                                padding: 12px;
                                border-radius: 8px;
                                font-size: 1rem;
                                font-weight: 700;
                                cursor: pointer;
                                text-decoration: none;
                                transition: opacity 0.2s;
                            }

                            .btn-book:hover {
                                opacity: 0.88;
                            }

                            .empty-state {
                                text-align: center;
                                color: #666;
                                padding: 60px 20px;
                                grid-column: 1/-1;
                            }

                            .empty-state h3 {
                                font-size: 1.5rem;
                                margin-bottom: 10px;
                                color: #1b5e20;
                            }

                            /* ABOUT SECTION REDESIGN */
                            .about-section {
                                background: white;
                                padding: 70px 40px;
                                margin: 50px auto;
                                max-width: 1300px;
                                border-radius: 24px;
                                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.04);
                            }

                            .about-container {
                                display: flex;
                                gap: 50px;
                                align-items: flex-start;
                                text-align: left;
                            }

                            .about-media {
                                flex: 1;
                                border-radius: 16px;
                                overflow: hidden;
                                display: flex;
                                align-items: center;
                                justify-content: center;
                            }

                            .about-illustration-img {
                                width: 100%;
                                height: auto;
                                max-height: 480px;
                                object-fit: contain;
                            }

                            .about-content {
                                flex: 1.2;
                            }

                            .about-badge {
                                display: inline-block;
                                background: #e8f5e9;
                                color: #2e7d32;
                                padding: 6px 16px;
                                border-radius: 20px;
                                font-weight: 700;
                                font-size: 0.85rem;
                                text-transform: uppercase;
                                letter-spacing: 1px;
                                margin-bottom: 15px;
                            }

                            .about-title {
                                font-size: 2.2rem;
                                font-weight: 800;
                                color: #1b5e20;
                                line-height: 1.3;
                                margin-bottom: 20px;
                            }

                            .about-desc {
                                font-size: 1.05rem;
                                line-height: 1.7;
                                color: #555;
                                margin-bottom: 25px;
                            }

                            .mission-vision-grid {
                                display: grid;
                                grid-template-columns: 1fr 1fr;
                                gap: 20px;
                                margin-bottom: 25px;
                            }

                            .mv-card {
                                background: #f9fbf9;
                                border: 1px solid #e8f0e8;
                                padding: 18px;
                                border-radius: 12px;
                            }

                            .mv-card h4 {
                                color: #1b5e20;
                                font-size: 1.1rem;
                                font-weight: 700;
                                margin-bottom: 8px;
                                display: flex;
                                align-items: center;
                                gap: 8px;
                            }

                            .mv-card p {
                                font-size: 0.88rem;
                                color: #555;
                                line-height: 1.5;
                            }

                            .why-ecotravel {
                                margin-bottom: 25px;
                            }

                            .why-ecotravel h4 {
                                color: #1b5e20;
                                font-size: 1.25rem;
                                font-weight: 700;
                                margin-bottom: 12px;
                            }

                            .why-list {
                                list-style: none;
                                display: grid;
                                grid-template-columns: 1fr 1fr;
                                gap: 10px;
                                padding: 0;
                            }

                            .why-item {
                                display: flex;
                                align-items: center;
                                gap: 8px;
                                font-size: 0.92rem;
                                color: #444;
                                font-weight: 600;
                            }

                            .why-icon {
                                color: #2e7d32;
                                font-weight: bold;
                            }

                            .core-values {
                                border-top: 1px solid #e8f0e8;
                                padding-top: 25px;
                            }

                            .core-values h4 {
                                color: #1b5e20;
                                font-size: 1.25rem;
                                font-weight: 700;
                                margin-bottom: 15px;
                            }

                            .values-grid {
                                display: grid;
                                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                                gap: 15px;
                            }

                            .value-card {
                                background: #f1f8f1;
                                border-left: 4px solid #2e7d32;
                                padding: 12px 16px;
                                border-radius: 0 8px 8px 0;
                            }

                            .value-card strong {
                                color: #1b5e20;
                                display: block;
                                font-size: 0.95rem;
                                margin-bottom: 4px;
                            }

                            .value-card span {
                                font-size: 0.85rem;
                                color: #555;
                                line-height: 1.4;
                                display: block;
                            }

                            @media (max-width: 992px) {
                                .about-container {
                                    flex-direction: column;
                                }

                                .about-media {
                                    width: 100%;
                                }
                            }

                            footer {
                                background: #1b5e20;
                                color: rgba(255, 255, 255, 0.8);
                                text-align: center;
                                padding: 24px;
                                margin-top: 60px;
                                font-size: 0.9rem;
                            }
                        </style>
                    </head>

                    <body>
                        <nav class="navbar">
                            <a href="index.jsp" class="logo-container">🌿 EcoTravel</a>

                            <ul class="nav-menu">
                                <li><a href="index.jsp">Home</a></li>
                                <li><a href="destinations?action=hotels">Hotels</a></li>
                                <li><a href="#tours">Green Tours</a></li>
                                <li><a href="#about">About Us</a></li>
                            </ul>

                            <div class="nav-actions">
                                <% if (currentUser==null) { %>
                                    <a href="user_login.jsp" class="nav-link-btn">Login</a>
                                    <a href="user_login.jsp?action=register" class="btn-signup">Sign Up</a>
                                    <a href="admin_login.jsp" class="nav-link-admin">Admin</a>
                                    <% } else { %>
                                        <a href="my_bookings.jsp" class="nav-link-btn">My Bookings</a>
                                        <div class="user-profile">
                                            <span class="user-greeting">Hi, <%= currentUser.getUsername() %> 👋</span>
                                            <img src="https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=80&q=80"
                                                alt="Avatar" class="avatar">
                                        </div>
                                        <a href="auth?action=logout" class="btn-logout">Logout</a>
                                        <% } %>
                            </div>
                        </nav>

                        <header class="hero">
                            <div class="hero-content">
                                <% if (currentUser !=null) { %>
                                    <div class="greeting">Hi, <%= currentUser.getUsername() %> 👋</div>
                                    <% } %>
                                        <h1>Welcome to<br><span>EcoTravel Karnataka</span></h1>
                                        <p>Embrace the Earth – Sustainable Adventures Across Karnataka.<br>Your premier
                                            portal for responsible and eco-friendly tourism.</p>
                                        <a href="#tours" class="btn-hero">🌿 Explore Eco-Tours</a>
                            </div>
                        </header>

                        <section id="tours" class="tours-section">
                            <div class="tour-grid">
                                <% 
    if (topDestinations != null && !topDestinations.isEmpty()) {
        for (Destination d : topDestinations) {
            String imgUrl = d.getImageUrl();
            // Build correct image src - file-upload paths need context prefix
            String imgSrc;
            if (imgUrl != null && (imgUrl.startsWith("http://") || imgUrl.startsWith("https://"))) {
                imgSrc = imgUrl;
            } else if (imgUrl != null && !imgUrl.isEmpty()) {
                imgSrc = ctxPath + "/" + imgUrl;
            } else {
                imgSrc = "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=600&q=80";
            }
%>
                                    <div class="tour-card"
                                        onclick="window.location.href='destinations?action=view&id=<%= d.getId() %>'"
                                        style="cursor: pointer;">
                                        <img src="<%= imgSrc %>" alt="<%= d.getName() %>" class="tour-image"
                                            onerror="this.src='https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=600&q=80'">
                                        <div class="tour-info" style="text-align: center; padding: 15px 10px;">
                                            <h3
                                                style="margin: 0; font-size: 1.25rem; font-weight: 700; color: #1b5e20;">
                                                <%= d.getName() %>
                                            </h3>
                                        </div>
                                    </div>
                                    <% } } else { %>
                                        <div class="empty-state">
                                            <h3>No destinations added yet</h3>
                                            <p>Admin can add eco-destinations from the Admin Portal.</p>
                                        </div>
                                        <% } %>
                            </div>
                        </section>

                        <!-- ABOUT US SECTION -->
                        <section id="about" class="about-section">
                            <div class="about-container">
                                <div class="about-media">
                                    <img src="images/about_illustration.png" alt="EcoTravel Illustration"
                                        class="about-illustration-img">
                                </div>

                                <div class="about-content">
                                    <span class="about-badge">🌿 About EcoTravel</span>
                                    <h2 class="about-title">Empowering Green Journeys</h2>
                                    <p class="about-desc">EcoTravel is a sustainable tourism platform that helps
                                        travelers discover eco-friendly destinations and responsible travel experiences.
                                        Our goal is to promote environmental awareness and encourage green travel
                                        practices while preserving nature for future generations.</p>

                                    <div class="mission-vision-grid">
                                        <div class="mv-card">
                                            <h4>🎯 Mission</h4>
                                            <p>To inspire travelers to make environmentally responsible travel choices
                                                through eco-friendly destinations and sustainable tourism.</p>
                                        </div>
                                        <div class="mv-card">
                                            <h4>👁️ Vision</h4>
                                            <p>To become a trusted platform that promotes eco-tourism and contributes to
                                                a greener future.</p>
                                        </div>
                                    </div>

                                    <div class="why-ecotravel">
                                        <h4>🌎 Why EcoTravel?</h4>
                                        <ul class="why-list">
                                            <li class="why-item"><span class="why-icon">✓</span> Eco-friendly
                                                destinations</li>
                                            <li class="why-item"><span class="why-icon">✓</span> Sustainable travel
                                                promotion</li>
                                            <li class="why-item"><span class="why-icon">✓</span> Nature conservation
                                                awareness</li>
                                            <li class="why-item"><span class="why-icon">✓</span> Easy and user-friendly
                                                booking</li>
                                        </ul>
                                    </div>

                                    <div class="core-values">
                                        <h4>⭐ Core Values</h4>
                                        <div class="values-grid">
                                            <div class="value-card">
                                                <strong>🌱 Sustainability</strong>
                                                <span>Protecting the environment and natural resources.</span>
                                            </div>
                                            <div class="value-card">
                                                <strong>🤝 Responsibility</strong>
                                                <span>Respecting local communities and ecosystems.</span>
                                            </div>
                                            <div class="value-card">
                                                <strong>🌍 Conservation</strong>
                                                <span>Supporting nature and wildlife protection.</span>
                                            </div>
                                            <div class="value-card">
                                                <strong>💚 Green Travel</strong>
                                                <span>Encouraging environmentally friendly travel choices.</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>

                        <!-- FOOTER -->
                        <footer
                            style="background:#1b5e20; color:rgba(255,255,255,0.85); padding:30px 20px; font-family:'Outfit',sans-serif; text-align:center; margin-top:60px;">
                            <div
                                style="max-width:1100px; margin:0 auto; display:flex; flex-direction:column; gap:16px;">
                                <div
                                    style="display:flex; justify-content:center; gap:24px; flex-wrap:wrap; font-size:0.9rem;">
                                    <span style="color:rgba(255,255,255,0.8);">📧 info@ecotravel.in</span>
                                    <span style="color:rgba(255,255,255,0.8);">📞 +91 98765 43210</span>
                                    <span style="color:rgba(255,255,255,0.8);">📍 Bengaluru, Karnataka</span>
                                    <a href="admin_login.jsp"
                                        style="color:#a5d6a7; text-decoration:none; font-weight:600; transition:color 0.2s;"
                                        onmouseover="this.style.color='white'"
                                        onmouseout="this.style.color='#a5d6a7'">🔧 Admin Portal</a>
                                </div>
                                <div
                                    style="border-top:1px solid rgba(255,255,255,0.15); padding-top:16px; font-size:0.85rem; color:rgba(255,255,255,0.6);">
                                    © 2026 EcoTravel Karnataka. All rights reserved. Promoting Sustainable Tourism. 🌿
                                </div>
                            </div>
                        </footer>
                    </body>

                    </html>