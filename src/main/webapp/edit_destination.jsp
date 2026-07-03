<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>Edit Destination - EcoTravel</title>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4fdf4; margin: 0; padding:40px;}
        .container { max-width: 600px; margin: 0 auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); }
        input, textarea { width:100%; padding:10px; margin-bottom:15px; border:1px solid #ccc; border-radius:4px; box-sizing:border-box; }
        .btn { padding:12px 25px; background:#1976d2; color:white; border:none; border-radius:4px; font-weight:bold; cursor:pointer; width:100%;}
        .current-image { width:100%; height:220px; object-fit:cover; border-radius:8px; margin:8px 0 15px; border:1px solid #ddd; background:#f5f5f5; }
        .help-text { display:block; margin:-8px 0 12px; font-size:12px; color:#666; }
    </style>
</head>
<body>
    <div class="container">
        <h2 style="color: #1976d2; margin-top:0;">✏️ Edit Destination Details</h2>
        <form action="destinations" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="updateDestination">
            <input type="hidden" name="id" value="${dest.id}">
            <input type="hidden" name="currentImageUrl" value="${dest.imageUrl}">
            
            <label>Destination Name</label>
            <input type="text" name="name" value="${dest.name}" required>

            <label>Current Destination Image</label>
            <img src="${dest.imageUrl}" alt="${dest.name}" class="current-image"
                 onerror="this.src='https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=800&q=80'">

            <label>Update Image URL</label>
            <input type="text" name="imageUrl" placeholder="Paste new image URL here">
            <span class="help-text">Leave both image fields empty to keep the current image.</span>

            <label>Or Upload New JPG Image</label>
            <input type="file" name="imageFile" accept=".jpg, .jpeg, image/jpeg">
            
            <label>Eco-Score (1-10)</label>
            <input type="number" name="ecoScore" min="1" max="10" value="${dest.ecoScore}" required>
            
            <label>Base Price (₹)</label>
            <input type="number" name="basePrice" value="${dest.basePrice}" required>
            
            <label>Description</label>
            <textarea name="description" rows="5" required>${dest.description}</textarea>
            
            <button type="submit" class="btn">Update Destination</button>
            <a href="destinations?action=admin" style="display:block; text-align:center; margin-top:15px; color:#555; text-decoration:none;">Cancel and Go Back</a>
        </form>
    </div>
</body>
</html>
