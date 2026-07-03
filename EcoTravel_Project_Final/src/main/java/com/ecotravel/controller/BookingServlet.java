package com.ecotravel.controller;

import com.ecotravel.dao.BookingDao;
import com.ecotravel.dao.DestinationDao;
import com.ecotravel.model.Booking;
import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;
import com.ecotravel.model.Transport;
import com.ecotravel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/bookings")
public class BookingServlet extends HttpServlet {
    private BookingDao bookingDao = new BookingDao();
    private DestinationDao destDao = new DestinationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("user_auth.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        List<Booking> list = bookingDao.getBookingsByUser(user.getId());
        request.setAttribute("bookings", list);
        request.getRequestDispatcher("my_bookings.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("create".equals(action)) {
            HttpSession session = request.getSession(false);
            User user = null;
            if (session != null && session.getAttribute("user") != null) {
                user = (User) session.getAttribute("user");
            }
            // IF user is null, they are booking as a Guest!
            
            int destId = Integer.parseInt(request.getParameter("destId"));
            int hotelId = Integer.parseInt(request.getParameter("hotelId"));
            int transportId = Integer.parseInt(request.getParameter("transportId"));
            String contactName = request.getParameter("contactName");
            String contactMobile = request.getParameter("contactMobile");
            
            double totalCost = 0.0;
            for(Destination d : destDao.getAllDestinations()) {
                if(d.getId() == destId) totalCost += d.getBasePrice();
            }
            for(Hotel h : destDao.getHotelsByDestination(destId)) {
                if(h.getId() == hotelId) totalCost += h.getPricePerNight() * 3; // Standard 3 night package
            }
            for(Transport t : destDao.getTransportByDestination(destId)) {
                if(t.getId() == transportId) totalCost += t.getPrice();
            }

            Booking b = new Booking();
            b.setUserId(user != null ? user.getId() : 0);
            b.setDestinationId(destId);
            b.setHotelId(hotelId);
            b.setTransportId(transportId);
            b.setContactName(contactName);
            b.setContactMobile(contactMobile);
            b.setTotalCost(totalCost);
            b.setStatus("Confirmed");
            
            if (bookingDao.createBooking(b)) {
                if (user != null) {
                    response.sendRedirect("bookings?msg=Booking+Successful!+Your+Eco-Trip+is+Confirmed.&sms=" + contactMobile);
                } else {
                    response.sendRedirect("destinations?msg=Booking+Successful!+We+will+contact+you+shortly.&sms=" + contactMobile);
                }
            } else {
                response.sendRedirect("destinations?action=list&error=Booking+Failed");
            }
        }
    }
}
