package com.JavaWebApplication.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@MultipartConfig
public class AddToCartServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int foodId = Integer.parseInt(request.getParameter("id"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        int userId = 1; // Assume a static user for now, or retrieve from session

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO cart (user_id, food_id, quantity, status) VALUES (?, ?, ?, 'pending')";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, userId);
                pstmt.setInt(2, foodId);
                pstmt.setInt(3, quantity);

                int rowsAffected = pstmt.executeUpdate();
                System.out.println("Rows affected: " + rowsAffected);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/customer/jsp/Cart.jsp");
    }
}
