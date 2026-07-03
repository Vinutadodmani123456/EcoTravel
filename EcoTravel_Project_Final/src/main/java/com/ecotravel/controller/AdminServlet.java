package com.ecotravel.controller;

import com.ecotravel.dao.BookingDao;
import com.ecotravel.dao.UserDao;
import com.ecotravel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin")
public class AdminServlet extends HttpServlet {
    private UserDao userDao = new UserDao();
    private BookingDao bookingDao = new BookingDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("user_auth.jsp");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"admin".equals(user.getRole())) {
            response.sendRedirect("dashboard.jsp");
            return;
        }

        request.setAttribute("users", userDao.getAllUsers());
        request.setAttribute("bookings", bookingDao.getAllBookings());
        request.getRequestDispatcher("admin.jsp").forward(request, response);
    }
}
