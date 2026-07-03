<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
    if (user == null) { response.sendRedirect("user_login.jsp"); return; }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile – EcoTravel Karnataka</title>
    <meta name="description" content="Manage your EcoTravel profile and personal information.">
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

        /* PAGE HERO */
        .page-hero {
            background: linear-gradient(135deg, #1b5e20 0%, #2e7d32 60%, #388e3c 100%);
            padding: 50px 30px;
            text-align: center;
            color: white;
        }
        .page-hero .avatar-circle {
            width: 90px; height: 90px;
            background: rgba(255,255,255,0.2);
            border: 3px solid rgba(255,255,255,0.5);
            border-radius: 50%;
            display: flex; align-items: center; justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto 16px;
        }
        .page-hero h1 { font-size: 2rem; font-weight: 800; margin-bottom: 6px; }
        .page-hero p { font-size: 1rem; color: rgba(255,255,255,0.8); }

        /* MAIN */
        .main-content { max-width: 600px; margin: 40px auto; padding: 0 20px 60px; }

        /* SUCCESS */
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 14px 20px; border-radius: 10px; margin-bottom: 24px; text-align: center; font-weight: 600; }

        /* CARD */
        .profile-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0,0,0,0.08);
            overflow: hidden;
        }
        .card-section-title {
            background: #f1f8f1;
            border-bottom: 1px solid #e0f0e0;
            padding: 16px 28px;
            font-size: 0.85rem;
            font-weight: 700;
            color: #2e7d32;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        .card-body { padding: 28px; }

        .form-group { margin-bottom: 22px; }
        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 700;
            color: #1b5e20;
            font-size: 0.9rem;
        }
        .form-group .label-icon { margin-right: 6px; }

        .form-group input[type="text"],
        .form-group input[type="email"],
        .form-group input[type="password"] {
            width: 100%;
            padding: 13px 16px;
            border: 2px solid #e0e0e0;
            border-radius: 10px;
            font-size: 1rem;
            font-family: 'Outfit', sans-serif;
            color: #222;
            transition: border-color 0.2s, box-shadow 0.2s;
            outline: none;
        }
        .form-group input:focus {
            border-color: #2e7d32;
            box-shadow: 0 0 0 3px rgba(46,125,50,0.12);
        }

        .hint { font-size: 0.78rem; color: #888; margin-top: 5px; }

        .btn-save {
            width: 100%;
            padding: 15px;
            background: linear-gradient(135deg, #2e7d32, #1b5e20);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1.05rem;
            font-weight: 700;
            cursor: pointer;
            transition: transform 0.2s, box-shadow 0.2s;
            font-family: 'Outfit', sans-serif;
            box-shadow: 0 4px 15px rgba(46,125,50,0.3);
        }
        .btn-save:hover { transform: translateY(-2px); box-shadow: 0 8px 25px rgba(46,125,50,0.4); }

        /* QUICK LINKS */
        .quick-links { display: flex; gap: 12px; margin-top: 16px; }
        .quick-link { flex: 1; display: block; text-align: center; padding: 12px; border-radius: 10px; text-decoration: none; font-weight: 700; font-size: 0.88rem; transition: all 0.2s; }
        .ql-bookings { background: #e8f5e9; color: #1b5e20; }
        .ql-bookings:hover { background: #c8e6c9; }
        .ql-home { background: #f3e5f5; color: #6a1b9a; }
        .ql-home:hover { background: #e1bee7; }

        footer { background: #1b5e20; color: rgba(255,255,255,0.8); text-align: center; padding: 24px; font-size: 0.9rem; }
    </style>
</head>
<body>
    <!-- NAVBAR -->
    <nav class="navbar">
        <a href="index.jsp" class="logo-container">🌿 EcoTravel</a>
        <ul class="nav-menu">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="destinations?action=hotels">Hotels</a></li>
            <li><a href="my_bookings.jsp">My Bookings</a></li>
        </ul>
        <a href="auth?action=logout" class="btn-logout">Logout</a>
    </nav>

    <!-- PAGE HERO -->
    <div class="page-hero">
        <div class="avatar-circle">👤</div>
        <h1>My Profile</h1>
        <p>Manage your EcoTravel account details</p>
    </div>

    <!-- MAIN -->
    <div class="main-content">
        <% if (request.getParameter("msg") != null) { %>
            <div class="alert-success">✅ <%= request.getParameter("msg") %></div>
        <% } %>

        <div class="profile-card">
            <div class="card-section-title">👤 Personal Information</div>
            <div class="card-body">
                <form action="auth" method="post">
                    <input type="hidden" name="action" value="updateProfile">
                    <input type="hidden" name="id" value="<%= user.getId() %>">

                    <div class="form-group">
                        <label><span class="label-icon">🙋</span> Username</label>
                        <input type="text" name="username" value="<%= user.getUsername() %>" required>
                    </div>

                    <div class="form-group">
                        <label><span class="label-icon">📧</span> Email Address</label>
                        <input type="email" name="email" value="<%= user.getEmail() %>" required>
                    </div>

                    <div class="form-group">
                        <label><span class="label-icon">🔒</span> Password</label>
                        <input type="password" name="password"
                               value="<%= user.getPassword() %>"
                               pattern="(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])(?=.*[@#$%&*!.,])[A-Za-z0-9@#$%&*!.,]{6,}"
                               title="Min 6 chars, uppercase, lowercase, number & special char"
                               placeholder="Min 6 chars, 1 uppercase, 1 number, 1 special char"
                               required>
                        <p class="hint">Must contain uppercase, lowercase, number and special character (@#$%&*!.,)</p>
                    </div>

                    <button type="submit" class="btn-save">💾 Save Profile Changes</button>
                </form>

                <div class="quick-links">
                    <a href="my_bookings.jsp" class="quick-link ql-bookings">🗒️ My Bookings</a>
                    <a href="index.jsp" class="quick-link ql-home">🏠 Back to Home</a>
                </div>
            </div>
        </div>
    </div>

    <footer>
        <p>© 2026 EcoTravel Karnataka. Promoting Sustainable Tourism. 🌿</p>
    </footer>
</body>
</html>
