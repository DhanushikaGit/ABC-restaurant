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

public class EditOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("order_id"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT * FROM orders WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setInt(1, orderId);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    request.setAttribute("order_id", rs.getInt("id"));
                    request.setAttribute("food_name", rs.getString("food_name"));
                    request.setAttribute("food_price", rs.getBigDecimal("food_price"));
                    request.setAttribute("order_type", rs.getString("order_type"));
                    request.setAttribute("dine_in_time", rs.getTimestamp("dine_in_time"));
                    request.setAttribute("delivery_address", rs.getString("delivery_address"));
                    request.setAttribute("meal_size", rs.getString("meal_size"));
                    request.setAttribute("meal_type", rs.getString("meal_type"));
                    request.setAttribute("customer_name", rs.getString("customer_name"));
                    request.setAttribute("customer_email", rs.getString("customer_email"));
                    request.setAttribute("customer_contact", rs.getString("customer_contact"));
                    request.setAttribute("order_date", rs.getTimestamp("order_date"));
                    request.setAttribute("meal_quantity", rs.getInt("meal_quantity"));
                    request.setAttribute("total_price", rs.getBigDecimal("total_price"));
                }

                request.getRequestDispatcher("staff/jsp/EditOrder.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
