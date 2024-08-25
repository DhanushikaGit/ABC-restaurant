package com.JavaWebApplication.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set response content type
        response.setContentType("text/html;charset=UTF-8");
        
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");
        
        // Validate form data (optional but recommended)
        if(name == null || email == null || subject == null || message == null ||
           name.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            response.sendRedirect("error.jsp"); // Redirect to an error page if validation fails
            return;
        }

        // Initialize JDBC variables
        String sql = "INSERT INTO contact_messages (name, email, subject, message) VALUES (?, ?, ?, ?)";

        try {
            // Load JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Establish connection and prepare statement using try-with-resources
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {
                
                // Set parameters
                pstmt.setString(1, name);
                pstmt.setString(2, email);
                pstmt.setString(3, subject);
                pstmt.setString(4, message);
                
                // Execute update
                int rowsInserted = pstmt.executeUpdate();
                
                if (rowsInserted > 0) {
                    response.sendRedirect("/restaurant/customer/jsp/Thankyou.jsp"); // Success page
                } else {
                    response.sendRedirect("error.jsp"); // Error page
                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // JDBC Driver not found
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp"); // SQL error
        }
    }
}
