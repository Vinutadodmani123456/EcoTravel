<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>EcoTravel - Green Tour Planning Portal</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; margin: 0; padding: 0; background-color: #f0fdf4; color: #1f2937; text-align: center; }
        .hero { background: linear-gradient(rgba(46,125,50,0.8), rgba(46,125,50,0.8)), url('https://images.unsplash.com/photo-1518182170546-076616fdfaaf?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80'); background-size: cover; background-position: center; color: white; padding: 100px 20px; }
        h1 { font-size: 3.5rem; margin-bottom: 20px; }
        p { font-size: 1.2rem; max-width: 800px; margin: 0 auto 40px; line-height: 1.6; }
        .actions { display: flex; justify-content: center; gap: 20px; }
        .btn { padding: 15px 30px; font-size: 1.1rem; text-decoration: none; border-radius: 8px; font-weight: bold; transition: background 0.3s; }
        .btn-primary { background-color: #ffffff; color: #2e7d32; }
        .btn-primary:hover { background-color: #e8f5e9; }
        .btn-secondary { background-color: transparent; border: 2px solid #ffffff; color: white; }
        .btn-secondary:hover { background-color: rgba(255,255,255,0.1); }
        .btn-admin { background-color: #d84315; color: white; margin-top:20px; display:inline-block; padding:10px 20px; text-decoration:none; border-radius:4px;}
        .features { padding: 60px 20px; display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 40px; max-width: 1200px; margin: 0 auto; }
        .feature-card { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .feature-card h3 { color: #2e7d32; font-size: 1.5rem; }
    </style>
</head>
<body>
    <div style="background: #2e7d32; display: flex; justify-content: space-between; align-items: center; padding: 15px 30px;">
        <div style="color: white; font-size: 1.5rem; font-weight: bold;">🌿 EcoTravel</div>
        <div>
            <a href="admin_login.jsp" style="color: white; text-decoration: none; font-weight: bold; border: 2px solid white; padding: 8px 15px; border-radius: 5px; transition: background 0.3s;" onmouseover="this.style.background='rgba(255,255,255,0.2)'" onmouseout="this.style.background='transparent'">Admin Login / Register</a>
        </div>
    </div>

    <div class="hero">
        <h1>Welcome to EcoTravel</h1>
        <p>Your premier portal for planning sustainable, eco-friendly green tours. We prioritize low-carbon transportation and eco-certified lodging so you can explore the world responsibly.</p>
        <div class="actions">
            <a href="destinations" class="btn btn-primary">Start Planning</a>
        </div>
    </div>

    <div class="features">
        <div class="feature-card">
            <h3>🍃 Eco-Scores</h3>
            <p>Every destination is rated based on environmental sustainability, helping you make informed green choices.</p>
        </div>
        <div class="feature-card">
            <h3>🏨 Green Hotels</h3>
            <p>We partner exclusively with verified eco-lodges that utilize solar energy, conserve water, and eliminate plastic.</p>
        </div>
        <div class="feature-card">
            <h3>🚆 Low-Emission Transit</h3>
            <p>Select from EV buses, shared safaris, and train routes to minimize your carbon footprint while traveling.</p>
        </div>
    </div>
</body>
</html>
