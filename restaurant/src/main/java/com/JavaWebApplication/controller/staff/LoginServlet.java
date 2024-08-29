package com.JavaWebApplication.controller.staff;

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

public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Load the MySQL JDBC driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            // SQL query to check if the staff member exists
            String sql = "SELECT id, name, position FROM staff WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                // Create a session and set the staff attributes
                HttpSession session = request.getSession();
                session.setAttribute("staffId", rs.getInt("id"));
                session.setAttribute("staffName", rs.getString("name"));
                session.setAttribute("staffPosition", rs.getString("position"));

                // Redirect to the EditOrder.jsp page
                response.sendRedirect("/restaurant/staff/jsp/EditOrder.jsp");
            } else {
                // If the login fails, show an error message
                request.setAttribute("errorMessage", "Invalid email or password");
                request.getRequestDispatcher("/staff/jsp/login.jsp").forward(request, response);
            }
        } catch (Exception e) {
            // Log the exception and display a generic error message
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred. Please try again.");
            request.getRequestDispatcher("/staff/jsp/login.jsp").forward(request, response);
        } finally {
            // Close the resources
            if (rs != null) try { rs.close(); } catch (Exception e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (Exception e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
        }
    }
}
