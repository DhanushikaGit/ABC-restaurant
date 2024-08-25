package com.JavaWebApplication.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class AdminLogin
 */
public class AdminLogin extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AdminLogin() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        boolean isValidUser = authenticateAdmin(username, password);

        if (isValidUser) {
            HttpSession session = request.getSession();
            session.setAttribute("username", username);
            response.sendRedirect(request.getContextPath() + "/admin/jsp/adminDashboard.jsp"); // Ensure this file exists and is in the correct directory
        } else {
            request.setAttribute("errorMessage", "Invalid username or password.");
            request.getRequestDispatcher("/admin/jsp/adminLogin.jsp").forward(request, response); // Update path if needed
        }
    }


    private boolean authenticateAdmin(String username, String password) {
        boolean isValid = false;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // Correct JDBC Driver class
            try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                String query = "SELECT * FROM admin_login WHERE username = ? AND password = ?";
                try (PreparedStatement pstmt = connection.prepareStatement(query)) {
                    pstmt.setString(1, username);
                    pstmt.setString(2, password);
                    try (ResultSet rs = pstmt.executeQuery()) {
                        if (rs.next()) {
                            isValid = true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return isValid;
    }
}
