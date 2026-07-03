package com.ecotravel.controller;

import com.ecotravel.dao.BookingDao;
import com.ecotravel.dao.DestinationDao;
import com.ecotravel.model.Booking;
import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;

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
        String action = request.getParameter("action");
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("user_login.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");

        if ("edit".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("id"));
            Booking b = bookingDao.getBookingById(bookingId);
            if (b != null && b.getUserId() == user.getId()) {
                request.setAttribute("booking", b);
                request.getRequestDispatcher("edit_booking.jsp").forward(request, response);
            } else {
                response.sendRedirect("bookings?msg=Booking+not+found.");
            }
        } else {
            List<Booking> list = bookingDao.getBookingsByUser(user.getId());
            request.setAttribute("bookings", list);
            request.getRequestDispatcher("my_bookings.jsp").forward(request, response);
        }
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
            String bookingType = request.getParameter("bookingType");
            if (bookingType == null || bookingType.isEmpty()) {
                bookingType = "destination";
            }
            
            String contactName = request.getParameter("contactName");
            String contactMobile = request.getParameter("contactMobile");
            String contactEmail = request.getParameter("contactEmail");
            double totalCost = 0.0;
            
            Booking b = new Booking();
            b.setUserId(user != null ? user.getId() : 0);
            b.setContactName(contactName);
            b.setContactMobile(contactMobile);
            b.setEmail(contactEmail);
            b.setBookingType(bookingType);

            if ("destination".equals(bookingType)) {
                int destId = Integer.parseInt(request.getParameter("destId"));
                b.setDestinationId(destId);
                
                for(Destination d : destDao.getAllDestinations()) {
                    if(d.getId() == destId) {
                        totalCost += d.getBasePrice();
                    }
                }
                
            } else if ("hotel".equals(bookingType)) {
                int hotelId = Integer.parseInt(request.getParameter("hotelId"));
                b.setHotelId(hotelId);
                
                String checkIn = request.getParameter("checkIn");
                String checkOut = request.getParameter("checkOut");
                String roomType = request.getParameter("roomType");
                int adults = request.getParameter("adults") != null ? Integer.parseInt(request.getParameter("adults")) : 2;
                int children = request.getParameter("children") != null ? Integer.parseInt(request.getParameter("children")) : 0;
                int rooms = request.getParameter("rooms") != null ? Integer.parseInt(request.getParameter("rooms")) : 1;
                
                b.setCheckIn(checkIn);
                b.setCheckOut(checkOut);
                b.setRoomType(roomType);
                b.setAdults(adults);
                b.setChildren(children);
                b.setRooms(rooms);
                
                Hotel hotelObj = destDao.getHotelById(hotelId);
                if (hotelObj != null) {
                    long nights = 1;
                    try {
                        java.time.LocalDate checkInDate = java.time.LocalDate.parse(checkIn);
                        java.time.LocalDate checkOutDate = java.time.LocalDate.parse(checkOut);
                        nights = java.time.temporal.ChronoUnit.DAYS.between(checkInDate, checkOutDate);
                        if (nights <= 0) nights = 1;
                    } catch (Exception e) {
                        nights = 1;
                    }
                    
                    double multiplier = "Double".equalsIgnoreCase(roomType) ? 1.5 : 1.0;
                    totalCost = nights * hotelObj.getPricePerNight() * multiplier;
                }
            }

            b.setTotalCost(totalCost);
            b.setStatus("Pending");
            
            int bookingId = bookingDao.createBooking(b);
            
            if(bookingId > 0) {
                response.sendRedirect("payment.jsp?bookingId=" + bookingId);
            } else {
                response.sendRedirect("destinations?action=list&error=Booking+Failed");
            }
        } else if ("confirmPayment".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            Booking b = bookingDao.getBookingById(bookingId);
            if (b != null) {
                boolean success = bookingDao.confirmBookingPayment(bookingId);
                if (success) {
                    // Log payment confirmed and prepare notification
                    System.out.println(">>> [DEBUG] Payment Confirmed. Sending Email and WhatsApp to: " + b.getEmail());

                    // Populate transient name fields if they are null
                    if ("hotel".equals(b.getBookingType())) {
                        com.ecotravel.model.Hotel h = destDao.getHotelById(b.getHotelId());
                        if (h != null) {
                            b.setHotelName(h.getName());
                        }
                    } else {
                        com.ecotravel.model.Destination d = destDao.getDestinationById(b.getDestinationId());
                        if (d != null) {
                            b.setDestinationName(d.getName());
                        }
                    }
                    // Determine the booked place (destination or hotel) name
                    String placeName = "hotel".equals(b.getBookingType()) ? b.getHotelName() : b.getDestinationName();

                    // Build confirmation message including the place name
                    String confirmationMsg = 
                    "*EcoTravel - Green Tour Planning Portal*\n" +
                    "--------------------------------------------\n" +
                    "*Booking Confirmed!*\n\n" +
                    "Hello, thank you for choosing a sustainable adventure with EcoTravel.\n\n" +
                    "Your trip to " + placeName + " has been confirmed.\n\n" +
                    "Your green trip has been validated and confirmed. We are excited to have you on board for a responsible travel experience!\n\n" +
                    "*Booking Status:* Confirmed\n" +
                    "*Eco-Score:* High\n\n" +
                    "Visit our portal for more details. Have a safe and green journey!\n" +
                    "--------------------------------------------\n" +
                    "*Travel Responsibly, Travel Green.*";
                    
                    com.ecotravel.util.EmailUtil.sendPlainEmail(b.getEmail(), "Booking Confirmed - EcoTravel Karnataka", confirmationMsg);
                    // SMS sending disabled per request

                // Send a simple plain message to user's phone number

                    
                    String successMsg;
                    if ("hotel".equals(b.getBookingType())) {
                        successMsg = "Booking+Successful!+Your+stay+at+" + b.getHotelName() + "+is+confirmed.";
                    } else {
                        successMsg = "Booking+Successful!+Your+trip+to+" + b.getDestinationName() + "+is+confirmed.";
                    }
                    
                    HttpSession session = request.getSession(false);
                    User user = (session != null) ? (User) session.getAttribute("user") : null;
                    if (user != null) {
                        response.sendRedirect("bookings?msg=" + successMsg);
                    } else {
                        response.sendRedirect("destinations?msg=" + successMsg);
                    }
                } else {
                    response.sendRedirect("destinations?action=list&error=Payment+Verification+Failed");
                }
            } else {
                response.sendRedirect("destinations?action=list&error=Booking+Not+Found");
            }
        } else if ("failPayment".equals(action)) {
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            bookingDao.failBookingPayment(bookingId);
            response.sendRedirect("destinations?error=Payment+not+completed.+Booking+is+still+Pending");
        } else if ("cancel".equals(action)) {
            // Cancel a booking and notify user via email and WhatsApp
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("user_login.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));

            // Retrieve booking details before cancellation for messaging
            Booking b = bookingDao.getBookingById(bookingId);
            boolean success = bookingDao.cancelBooking(bookingId, user.getId());
            if (success && b != null) {
                // Build cancellation message
                String tripName = "hotel".equals(b.getBookingType()) ? b.getHotelName() : b.getDestinationName();
                                String cancelMsg = 
                    "✅ EcoTravel - Green Tour Planning Portal\n" +
                    "--------------------------------------------\n" +
                    "Booking Cancelled!\n\n" +
                    "Hello, we regret to inform you that your trip to " + tripName + " has been cancelled.\n\n" +
                    "Booking Status: Cancelled\n" +
                    "Refund: Will be processed within 24 hours.\n\n" +
                    "Visit our portal for more details.";
                
                // Send email notification
                com.ecotravel.util.EmailUtil.sendPlainEmail(b.getEmail(), "Booking Cancelled - EcoTravel Karnataka", cancelMsg);

                
                // Redirect with formatted message for UI display
                String webDisplayMsg = cancelMsg.replace("\n", "<br>");
                response.sendRedirect("bookings?msg=" + java.net.URLEncoder.encode(webDisplayMsg, "UTF-8"));
            } else {
                response.sendRedirect("bookings?msg=Error:+Booking+cannot+be+cancelled.+It+may+be+past+the+48-hour+limit.");
            }
        } else if ("update".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("user_login.jsp");
                return;
            }
            User user = (User) session.getAttribute("user");
            int bookingId = Integer.parseInt(request.getParameter("bookingId"));
            String contactName = request.getParameter("contactName");
            String contactMobile = request.getParameter("contactMobile");
            
            boolean success = bookingDao.updateBookingDetails(bookingId, user.getId(), contactName, contactMobile);
            if (success) {
                response.sendRedirect("bookings?msg=Passenger+Details+Successfully+Updated.");
            } else {
                response.sendRedirect("bookings?msg=Error:+Cannot+update+details.");
            }
        }
    }
}
