package com.ecotravel.controller;

import com.ecotravel.dao.DestinationDao;
import com.ecotravel.model.Destination;
import com.ecotravel.model.Hotel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {
    
    private DestinationDao destDao = new DestinationDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String location = request.getParameter("location");
        String checkIn = request.getParameter("checkIn");
        String checkOut = request.getParameter("checkOut");
        String adults = request.getParameter("adults");
        String children = request.getParameter("children");
        String rooms = request.getParameter("rooms");
        
        List<Hotel> searchResults = new ArrayList<>();
        
        if (location != null && !location.trim().isEmpty()) {
            location = location.toLowerCase().trim();
            // Fetch all hotels and manually filter (or write a new DAO method if preferred)
            // Using existing DAO methods for simplicity
            List<Hotel> allHotels = destDao.getAllHotels();
            List<Destination> allDests = destDao.getAllDestinations();
            
            // Find destination IDs matching the location string
            List<Integer> matchingDestIds = new ArrayList<>();
            for (Destination d : allDests) {
                if (d.getName().toLowerCase().contains(location)) {
                    matchingDestIds.add(d.getId());
                }
            }
            
            searchResults = new ArrayList<>();
            for (Hotel h : allHotels) {
                // If hotel name matches OR destination matches
                if (h.getName().toLowerCase().contains(location) || matchingDestIds.contains(h.getDestinationId())) {
                    searchResults.add(h);
                }
            }
        }
        
        request.setAttribute("location", location);
        request.setAttribute("checkIn", checkIn);
        request.setAttribute("checkOut", checkOut);
        request.setAttribute("adults", adults);
        request.setAttribute("children", children);
        request.setAttribute("rooms", rooms);
        request.setAttribute("searchResults", searchResults);
        
        request.getRequestDispatcher("search_results.jsp").forward(request, response);
    }
}
