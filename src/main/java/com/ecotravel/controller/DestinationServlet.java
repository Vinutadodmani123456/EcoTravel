package com.ecotravel.controller;

import com.ecotravel.dao.DestinationDao;
import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;

import com.ecotravel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/destinations")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
                 maxFileSize = 1024 * 1024 * 10,      // 10MB
                 maxRequestSize = 1024 * 1024 * 50)   // 50MB
public class DestinationServlet extends HttpServlet {
    private DestinationDao destDao = new DestinationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("view".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            List<Destination> list = destDao.getAllDestinations();
            Destination d = list.stream().filter(x -> x.getId() == id).findFirst().orElse(null);
            
            if (d != null) {
                List<Hotel> hotels = destDao.getHotelsByDestination(id);
                request.setAttribute("destination", d);
                request.setAttribute("hotels", hotels);
                request.getRequestDispatcher("book.jsp").forward(request, response);
            } else {
                response.sendRedirect("destinations");
            }
        } 
        else if ("admin".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("admin_login.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");
            if (!"admin".equals(user.getRole())) {
                response.sendRedirect("user_login.jsp?error=Access+Denied");
                return;
            }
            com.ecotravel.dao.UserDao uDao = new com.ecotravel.dao.UserDao();
            com.ecotravel.dao.BookingDao bDao = new com.ecotravel.dao.BookingDao();
            request.setAttribute("users", uDao.getAllUsers());
            request.setAttribute("bookings", bDao.getAllBookings());
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        }
        else if ("edit".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"admin".equals(((User)session.getAttribute("user")).getRole())) return;
            int id = Integer.parseInt(request.getParameter("id"));
            Destination d = destDao.getAllDestinations().stream().filter(x -> x.getId() == id).findFirst().orElse(null);
            if(d != null) {
                request.setAttribute("dest", d);
                request.getRequestDispatcher("edit_destination.jsp").forward(request, response);
            } else {
                response.sendRedirect("destinations?action=admin");
            }
        }
        else if ("delete".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"admin".equals(((User)session.getAttribute("user")).getRole())) return;
            int id = Integer.parseInt(request.getParameter("id"));
            destDao.deleteDestination(id);
            response.sendRedirect("destinations?action=admin&msg=Destination+Deleted+Successfully!");
        }
        else if ("hotels".equals(action)) {
            String destinationId = request.getParameter("destinationId");
            if (destinationId != null && !destinationId.trim().isEmpty()) {
                int id = Integer.parseInt(destinationId);
                Destination d = destDao.getAllDestinations().stream().filter(x -> x.getId() == id).findFirst().orElse(null);
                request.setAttribute("destination", d);
                request.setAttribute("hotels", destDao.getHotelsByDestination(id));
            } else {
                request.setAttribute("hotels", destDao.getAllHotels());
            }
            request.getRequestDispatcher("hotels.jsp").forward(request, response);
        }
        else {
            List<Destination> list = destDao.getAllDestinations();
            String minScore = request.getParameter("minScore");
            if (minScore != null && !minScore.isEmpty()) {
                int score = Integer.parseInt(minScore);
                list = list.stream().filter(d -> d.getEcoScore() >= score).collect(Collectors.toList());
            }
            request.setAttribute("destinations", list);
            request.getRequestDispatcher("dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("addDestination".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"admin".equals(((User)session.getAttribute("user")).getRole())) {
                response.sendRedirect("admin_login.jsp?error=Access+Denied");
                return;
            }
            
            Destination d = new Destination();
            d.setName(request.getParameter("name"));
            
            d.setImageUrl(resolveDestinationImageUrl(request, null));
            
            d.setEcoScore(Integer.parseInt(request.getParameter("ecoScore")));
            d.setBasePrice(Double.parseDouble(request.getParameter("basePrice")));
            d.setDescription(request.getParameter("description"));
            // mapEmbed is optional
            String mapEmbed = request.getParameter("mapEmbed");
            d.setMapEmbed(mapEmbed != null ? mapEmbed.trim() : "");
            
            destDao.addDestination(d);
            response.sendRedirect("destinations?action=admin&msg=New+Destination+Successfully+Added!");
        }
        else if ("updateDestination".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null || !"admin".equals(((User)session.getAttribute("user")).getRole())) {
                response.sendRedirect("admin_login.jsp?error=Access+Denied");
                return;
            }
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            int ecoScore = Integer.parseInt(request.getParameter("ecoScore"));
            double basePrice = Double.parseDouble(request.getParameter("basePrice"));
            String desc = request.getParameter("description");
            String currentImageUrl = request.getParameter("currentImageUrl");
            String imageUrl = resolveDestinationImageUrl(request, currentImageUrl);
            
            destDao.updateDestination(id, name, ecoScore, basePrice, desc, imageUrl);
            response.sendRedirect("destinations?action=admin&msg=Destination+Updated+Successfully!");
        }
        else if ("addHotel".equals(action)) {
            Hotel h = new Hotel();
            h.setDestinationId(Integer.parseInt(request.getParameter("destinationId")));
            h.setName(request.getParameter("name"));
            h.setDescription(request.getParameter("description"));
            h.setImageUrl(request.getParameter("imageUrl"));
            h.setEcoRating(Integer.parseInt(request.getParameter("ecoRating")));
            h.setPricePerNight(Double.parseDouble(request.getParameter("pricePerNight")));
            destDao.addHotel(h);
            response.sendRedirect("destinations?action=admin&hotelMsg=Hotel+Added+Successfully!");
        }
    }

    private String resolveDestinationImageUrl(HttpServletRequest request, String currentImageUrl) throws IOException, ServletException {
        String imageUrlParam = request.getParameter("imageUrl");
        if (imageUrlParam != null && !imageUrlParam.trim().isEmpty()) {
            return imageUrlParam.trim();
        }

        Part part = request.getPart("imageFile");
        if (part != null && part.getSize() > 0) {
            String fileName = System.currentTimeMillis() + ".jpg";
            File uploadDir = new File(FileUploadServlet.UPLOAD_DIR);
            if (!uploadDir.exists()) uploadDir.mkdirs();
            File destFile = new File(uploadDir, fileName);
            try (InputStream in = part.getInputStream();
                 FileOutputStream out = new FileOutputStream(destFile)) {
                byte[] buffer = new byte[8192];
                int bytesRead;
                while ((bytesRead = in.read(buffer)) != -1) out.write(buffer, 0, bytesRead);
            }
            return "file-upload/" + fileName;
        }

        if (currentImageUrl != null && !currentImageUrl.trim().isEmpty()) {
            return currentImageUrl.trim();
        }

        return "https://images.unsplash.com/photo-1506905925346-21bda4d32df4?auto=format&fit=crop&w=600&q=80";
    }
}
