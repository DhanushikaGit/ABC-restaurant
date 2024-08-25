package com.JavaWebApplication.controller;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@MultipartConfig
public class OrderFoodServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/restaurant";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "1234";
    private static final Logger LOGGER = Logger.getLogger(OrderFoodServlet.class.getName());

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve and validate form parameters
            int foodId = Integer.parseInt(request.getParameter("foodId"));
            String foodName = request.getParameter("foodName");
            String orderType = request.getParameter("orderType");
            String mealSize = request.getParameter("mealSize");
            String mealType = request.getParameter("mealType");
            int mealQuantity = Integer.parseInt(request.getParameter("mealQuantity"));
            BigDecimal foodPrice = new BigDecimal(request.getParameter("foodPrice"));
            String dineInTime = request.getParameter("dineInTime"); // nullable
            String deliveryAddress = request.getParameter("deliveryAddress"); // nullable
            String customerName = request.getParameter("customerName");
            String customerEmail = request.getParameter("customerEmail");
            String customerContact = request.getParameter("customerContact");

            // Validate the input parameters
            if (mealQuantity <= 0 || foodPrice.compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Invalid meal quantity or food price.");
            }

            // Calculate total price
            BigDecimal totalPrice = foodPrice.multiply(new BigDecimal(mealQuantity));

            // Prepare the SQL statement
            String sql = "INSERT INTO orders (food_id, food_name, food_price, order_type, dine_in_time, delivery_address, meal_size, meal_type, meal_quantity, total_price, customer_name, customer_email, customer_contact, order_date) "
                    + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)";

            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement pstmt = conn.prepareStatement(sql)) {

                pstmt.setInt(1, foodId);
                pstmt.setString(2, foodName);
                pstmt.setBigDecimal(3, foodPrice);
                pstmt.setString(4, orderType);
                pstmt.setObject(5, "dineIn".equals(orderType) ? dineInTime : null);
                pstmt.setObject(6, "online".equals(orderType) ? deliveryAddress : null);
                pstmt.setString(7, mealSize);
                pstmt.setString(8, mealType);
                pstmt.setInt(9, mealQuantity);
                pstmt.setBigDecimal(10, totalPrice);
                pstmt.setString(11, customerName);
                pstmt.setString(12, customerEmail);
                pstmt.setString(13, customerContact);

                pstmt.executeUpdate();

                LOGGER.info("Order placed successfully for customer: " + customerName);

            } catch (SQLException e) {
                LOGGER.severe("SQL Error: " + e.getMessage());
                throw e;
            }

            // Set attributes for confirmation page
            request.setAttribute("foodId", foodId);
            request.setAttribute("foodName", foodName);
            request.setAttribute("foodPrice", foodPrice);
            request.setAttribute("orderType", orderType);
            if ("dineIn".equals(orderType)) {
                request.setAttribute("dineInTime", dineInTime);
            }
            if ("online".equals(orderType)) {
                request.setAttribute("deliveryAddress", deliveryAddress);
            }
            request.setAttribute("mealSize", mealSize);
            request.setAttribute("mealType", mealType);
            request.setAttribute("mealQuantity", mealQuantity);
            request.setAttribute("totalPrice", totalPrice);
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerEmail", customerEmail);
            request.setAttribute("customerContact", customerContact);

            // Forward to the confirmation page
            RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/jsp/orderConfirmation.jsp");
            dispatcher.forward(request, response);

        } catch (Exception e) {
            LOGGER.severe("Error processing order: " + e.getMessage());
            request.setAttribute("errorMessage", "An error occurred while processing your order. Please try again.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("/customer/jsp/orderError.jsp");
            dispatcher.forward(request, response);
        }
    }
}
