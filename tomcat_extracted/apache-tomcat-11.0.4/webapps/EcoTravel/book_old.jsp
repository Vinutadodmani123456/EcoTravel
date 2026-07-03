<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%
    com.ecotravel.model.User user = (com.ecotravel.model.User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Book Trip - EcoTravel Karnataka</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; }
        .nav { background: #2e7d32; color: white; padding: 15px; }
        .nav a { color: white; text-decoration: none; margin-left: 15px; font-weight: bold; }
        .container { max-width: 800px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        h2 { color: #1b5e20; border-bottom: 2px solid #c8e6c9; padding-bottom: 10px; }
        .form-group { margin-bottom: 25px; }
        label { display: block; margin-bottom: 8px; font-weight: bold; color:#2e7d32;}
        input[type="text"], select { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 4px; font-size:16px; box-sizing:border-box;}
        .btn { padding: 15px 20px; background: #2e7d32; color: white; border:none; border-radius:4px; font-size:18px; cursor:pointer; width:100%; font-weight:bold;}
        .btn:hover { background: #1b5e20; }
        .eco-badge { background:#4caf50; color:white; padding:4px 8px; border-radius:4px; font-weight:bold; }
    </style>
</head>
<body>
    <div class="nav">
        <span style="font-size: 1.2em; font-weight: bold;">🌿 EcoTravel Karnataka</span>
        <a href="destinations">Back to Dashboard</a>
    </div>
    <div class="container">
        <h2>Book Your Eco-Trip to ${destination.name}</h2>
        <img src="${destination.imageUrl}" alt="${destination.name}" style="width:100%; height:300px; object-fit:cover; border-radius:8px; margin: 15px 0;">
        <div style="margin: 15px 0; overflow:hidden; border-radius:8px;">${destination.mapEmbed}</div>
        <p style="font-size:1.1em; color:#555;">${destination.description}</p>
        <p><strong>Destination Base Price:</strong> ₹${destination.basePrice}</p>
        <p><strong>Eco-Rating:</strong> 
            <span style="color: #fbc02d; font-weight: bold; font-size: 1.2rem;">${destination.ecoScore}*</span>
        </p>
        
        <form action="bookings" method="post" style="margin-top:30px;">
            <input type="hidden" name="action" value="create">
            <input type="hidden" name="destId" value="${destination.id}">
            
            <h3 style="color:#2e7d32; margin-top:30px;">1. Passenger Details</h3>
            <div class="form-group">
                <label>Passenger Full Name</label>
                <input type="text" name="contactName" placeholder="Enter traveler's name" pattern="[A-Za-z\s]+" title="Name must contain only letters" required>
            </div>
            <div class="form-group">
                <label>Mobile Number</label>
                <input type="text" name="contactMobile" placeholder="e.g. 9876543210" required pattern="\d{10}" maxlength="10" title="Please enter exactly 10 digits">
            </div>

            <h3 style="color:#2e7d32; margin-top:30px;">2. Book Hotel</h3>
            <div class="form-group">
                <label>Select Eco-Friendly Hotel near ${destination.name}</label>
                <div id="hotelPreview" style="display:none; margin-bottom:15px; background:#fff; border:1px solid #c8e6c9; border-radius:8px; padding:10px; display:flex; align-items:center; gap:15px;">
                    <img id="hotelImg" src="" style="width:120px; height:80px; object-fit:cover; border-radius:4px;">
                    <div>
                        <h4 id="hotelTitle" style="margin:0; color:#2e7d32;"></h4>
                        <p id="hotelDesc" style="margin:5px 0; font-size:0.9em; color:#666;"></p>
                    </div>
                </div>
                <select name="hotelId" id="hotelSelect" onchange="updateHotelPreview()" required>
                    <option value="" data-price="0" data-img="" data-desc="">-- Choose Eco-Accommodation (3 Nights Package) --</option>
                    <c:forEach var="h" items="${hotels}">
                        <option value="${h.id}" data-price="${h.pricePerNight * 3}" data-img="${h.imageUrl}" data-desc="${h.description}">${h.name} - EcoRating: ${h.ecoRating}/5 (₹${h.pricePerNight * 3} total)</option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="form-group">
                <label>Select Green Transport</label>
                <select name="transportId" id="transportSelect" onchange="calculateImpact()" required>
                    <option value="" data-price="0" data-carbon="0">-- Choose Zero/Low Emission Transport --</option>
                    <c:forEach var="t" items="${transports}">
                        <c:set var="cVal" value="${t.carbonFootprint == 'Zero' ? 0 : (t.carbonFootprint == 'Low' ? 15 : 45)}" />
                        <option value="${t.id}" data-price="${t.price}" data-carbon="${cVal}">${t.type} - Footprint: ${t.carbonFootprint} (₹${t.price})</option>
                    </c:forEach>
                </select>
            </div>
            
            <!-- Impact Calculator Dashboard -->
            <div style="background:#e8f5e9; border:2px solid #81c784; padding:15px; border-radius:8px; margin-top:15px;">
                <h4 style="margin:0 0 10px 0; color:#2e7d32;">📊 Live Trip Impact Calculator</h4>
                <p style="margin:5px 0;"><strong>Financial Cost:</strong> ₹<span id="calcTotal">${destination.basePrice}</span></p>
                <p style="margin:5px 0;"><strong>Carbon Footprint:</strong> <span id="calcCarbon" style="font-weight:bold; color:#d32f2f;">0</span> kg CO₂ <em style="font-size:0.9em; color:#666;">(Standard typical trips generate 150+ kg CO₂)</em></p>
                <p style="margin:5px 0;"><strong>Eco-Savings:</strong> You are saving an estimated <span id="calcSaved" style="color:#388e3c; font-weight:bold;">150</span> kg of CO₂ emissions!</p>
            </div>

            <h3 style="color:#2e7d32; margin-top:30px;">3. Zero-Plastic Digital Pledge</h3>
            <div class="form-group" style="background:#fff3e0; padding:15px; border-radius:8px; border-left:4px solid #ff9800;">
                <label style="display:flex; align-items:center; cursor:pointer;">
                    <input type="checkbox" required style="width:20px; height:20px; margin-right:10px;">
                    <span>I officially pledge to carry <strong>ZERO single-use plastics</strong> into this ecosystem. I understand this pledge acts as my verifiable Digital Green Pass.</span>
                </label>
            </div>

            <button type="submit" class="btn"><%= user != null ? "Confirm Details & Book Now" : "Confirm Booking as Guest" %></button>
        </form>
        
        <script>
            var basePrice = parseFloat("${destination.basePrice}") || 0;
            
            function updateHotelPreview() {
                var hotelSelect = document.getElementById("hotelSelect");
                var previewDiv = document.getElementById("hotelPreview");
                var hotelImg = document.getElementById("hotelImg");
                var hotelTitle = document.getElementById("hotelTitle");
                var hotelDesc = document.getElementById("hotelDesc");
                
                var selectedOption = hotelSelect.options[hotelSelect.selectedIndex];
                var img = selectedOption.getAttribute("data-img");
                var desc = selectedOption.getAttribute("data-desc");
                var name = selectedOption.text.split(" - ")[0];
                
                if (img && img !== "") {
                    previewDiv.style.display = "flex";
                    hotelImg.src = img;
                    hotelTitle.innerText = name;
                    hotelDesc.innerText = desc;
                } else {
                    previewDiv.style.display = "none";
                }
                
                calculateImpact();
            }

            function calculateImpact() {
                var hotelSelect = document.getElementById("hotelSelect");
                var transSelect = document.getElementById("transportSelect");
                
                var hotelPrice = hotelSelect.options[hotelSelect.selectedIndex].getAttribute("data-price");
                var transPrice = transSelect.options[transSelect.selectedIndex].getAttribute("data-price");
                var transCarbon = transSelect.options[transSelect.selectedIndex].getAttribute("data-carbon");
                
                hotelPrice = hotelPrice ? parseFloat(hotelPrice) : 0;
                transPrice = transPrice ? parseFloat(transPrice) : 0;
                transCarbon = transCarbon ? parseInt(transCarbon) : 0;
                
                var total = basePrice + hotelPrice + transPrice;
                document.getElementById("calcTotal").innerText = total.toFixed(2);
                document.getElementById("calcCarbon").innerText = transCarbon;
                
                var saved = 150 - transCarbon;
                document.getElementById("calcSaved").innerText = saved;
            }
        </script>
    </div>
</body>
</html>
