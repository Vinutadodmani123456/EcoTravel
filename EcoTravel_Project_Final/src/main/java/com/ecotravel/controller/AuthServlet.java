package com.ecotravel.controller;

import com.ecotravel.dao.UserDao;
import com.ecotravel.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDao userDao = new UserDao();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("register".equals(action)) {
            String userStr = request.getParameter("username");
            String passStr = request.getParameter("password");
            String emailStr = request.getParameter("email");
            
            User newUser = new User();
            newUser.setUsername(userStr);
            newUser.setPassword(passStr);
            newUser.setEmail(emailStr);
            newUser.setRole("admin");
            
            if (userDao.registerUser(newUser)) {
                response.sendRedirect("admin_login.jsp?msg=Registration+successful.+Please+log+in.&username=" + java.net.URLEncoder.encode(userStr, java.nio.charset.StandardCharsets.UTF_8));
            } else {
                response.sendRedirect("admin_login.jsp?error=Registration+failed.+Username+or+Email+already+exists.");
            }
        } else if ("login".equals(action)) {
            String userStr = request.getParameter("username");
            String passStr = request.getParameter("password");
            String loginType = request.getParameter("loginType"); // "user" or "admin"
            
            User u = userDao.loginUser(userStr, passStr);
            if (u != null) {
                if ("admin".equals(loginType) && !"admin".equals(u.getRole())) {
                    response.sendRedirect("admin_login.jsp?error=Access+Denied.+You+are+not+an+Administrator.");
                    return;
                }
                if ("user".equals(loginType) && "admin".equals(u.getRole())) {
                    response.sendRedirect("admin_login.jsp?error=Admins+must+use+the+Admin+Portal.");
                    return;
                }

                HttpSession session = request.getSession();
                session.setAttribute("user", u);
                
                if ("admin".equals(loginType)) {
                    response.sendRedirect("destinations?action=admin");
                } else {
                    response.sendRedirect("destinations");
                }
            } else {
                if ("admin".equals(loginType)) {
                    response.sendRedirect("admin_login.jsp?error=Invalid+Administrator+credentials.");
                } else {
                    response.sendRedirect("admin_login.jsp?error=Invalid+username+or+password.");
                }
            }
        }
    }
}
