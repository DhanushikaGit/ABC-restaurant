package com.JavaWebApplication.controller.staff;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Timestamp;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class UpdateOrderServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int orderId = Integer.parseInt(request.getParameter("order_id"));
        String foodName = request.getParameter("food_name");
        BigDecimal foodPrice = new BigDecimal(request.getParameter("food_price"));
        String orderType = request.getParameter("order_type");
        String dineInTime = request.getParameter("dine_in_time");
        String deliveryAddress = request.getParameter("delivery_address");
        String mealSize = request.getParameter("meal_size");
        String mealType = request.getParameter("meal_type");
        String customerName = request.getParameter("customer_name");
        String customerEmail = request.getParameter("customer_email");
        String customerContact = request.getParameter("customer_contact");
        String orderDate = request.getParameter("order_date");
        int mealQuantity = Integer.parseInt(request.getParameter("meal_quantity"));
        BigDecimal totalPrice = new BigDecimal(request.getParameter("total_price"));

        try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "UPDATE orders SET food_name = ?, food_price = ?, order_type = ?, dine_in_time = ?, delivery_address = ?, meal_size = ?, meal_type = ?, customer_name = ?, customer_email = ?, customer_contact = ?, order_date = ?, meal_quantity = ?, total_price = ? WHERE id = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
                pstmt.setString(1, foodName);
                pstmt.setBigDecimal(2, foodPrice);
                pstmt.setString(3, orderType);

                // Convert dineInTime to the required format
                if (dineInTime != null && !dineInTime.isEmpty()) {
                    dineInTime = dineInTime.replace("T", " ") + ":00";
                    pstmt.setTimestamp(4, Timestamp.valueOf(dineInTime));
                } else {
                    pstmt.setNull(4, java.sql.Types.TIMESTAMP);
                }

                pstmt.setString(5, deliveryAddress);
                pstmt.setString(6, mealSize);
                pstmt.setString(7, mealType);
                pstmt.setString(8, customerName);
                pstmt.setString(9, customerEmail);
                pstmt.setString(10, customerContact);

                // Convert orderDate to the required format
                if (orderDate != null && !orderDate.isEmpty()) {
                    orderDate = orderDate.replace("T", " ") + ":00";
                    pstmt.setTimestamp(11, Timestamp.valueOf(orderDate));
                } else {
                    pstmt.setNull(11, java.sql.Types.TIMESTAMP);
                }

                pstmt.setInt(12, mealQuantity);
                pstmt.setBigDecimal(13, totalPrice);
                pstmt.setInt(14, orderId);

                pstmt.executeUpdate();
            }

            // Redirect to the view order page after successful update
            response.sendRedirect("/restaurant/staff/jsp/vieworder.jsp");

        } catch (Exception e) {
            e.printStackTrace(response.getWriter());
            response.sendRedirect("/restaurant/staff/jsp/error.jsp");
        }
    }
}
