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
            String roleStr = request.getParameter("role");
            if (roleStr == null || roleStr.trim().isEmpty()) {
                roleStr = "admin";
            }
            
            String loginPage = "user".equals(roleStr) ? "user_login.jsp" : "admin_login.jsp";
            
            if (!isValidPassword(passStr)) {
                response.sendRedirect(loginPage + "?error=Password+must+be+at+least+6+characters+and+contain+at+least+1+uppercase,+1+lowercase,+1+number,+and+1+special+character+(@#$%26*!.,).");
                return;
            }
            
            User newUser = new User();
            newUser.setUsername(userStr);
            newUser.setPassword(passStr);
            newUser.setEmail(emailStr);
            newUser.setRole(roleStr);
            
            if (userDao.registerUser(newUser)) {
                response.sendRedirect(loginPage + "?msg=Registration+successful.+Please+log+in.&username=" + java.net.URLEncoder.encode(userStr, java.nio.charset.StandardCharsets.UTF_8));
            } else {
                response.sendRedirect(loginPage + "?error=Registration+failed.+Username+or+Email+already+exists.");
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
                    String redirectUrl = request.getParameter("redirect");
                    if (redirectUrl != null && !redirectUrl.trim().isEmpty()) {
                        response.sendRedirect(redirectUrl);
                    } else {
                        response.sendRedirect("destinations");
                    }
                }
            } else {
                if ("admin".equals(loginType)) {
                    response.sendRedirect("admin_login.jsp?error=Invalid+Administrator+credentials.");
                } else {
                    response.sendRedirect("user_login.jsp?error=Invalid+username+or+password.");
                }
            }
        } else if ("updateProfile".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                response.sendRedirect("user_login.jsp");
                return;
            }
            User currentUser = (User) session.getAttribute("user");
            
            String username = request.getParameter("username");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            
            if (!isValidPassword(password)) {
                response.sendRedirect("profile.jsp?msg=Password+must+be+at+least+6+characters+and+contain+at+least+1+uppercase,+1+lowercase,+1+number,+and+1+special+character+(@#$%26*!.,).");
                return;
            }
            
            currentUser.setUsername(username);
            currentUser.setEmail(email);
            currentUser.setPassword(password);
            
            if (userDao.updateUser(currentUser)) {
                session.setAttribute("user", currentUser);
                response.sendRedirect("profile.jsp?msg=Profile+updated+successfully!");
            } else {
                response.sendRedirect("profile.jsp?msg=Error+updating+profile.");
            }
        }
    }

    private boolean isValidPassword(String password) {
        if (password == null || password.length() < 6) {
            return false;
        }
        boolean hasUppercase = false;
        boolean hasLowercase = false;
        boolean hasNumber = false;
        boolean hasSpecial = false;
        
        String specialChars = "@#$%&*!.,";
        
        for (int i = 0; i < password.length(); i++) {
            char c = password.charAt(i);
            if (c >= 'A' && c <= 'Z') {
                hasUppercase = true;
            } else if (c >= 'a' && c <= 'z') {
                hasLowercase = true;
            } else if (c >= '0' && c <= '9') {
                hasNumber = true;
            } else if (specialChars.indexOf(c) >= 0) {
                hasSpecial = true;
            } else {
                return false;
            }
        }
        return hasUppercase && hasLowercase && hasNumber && hasSpecial;
    }
}
