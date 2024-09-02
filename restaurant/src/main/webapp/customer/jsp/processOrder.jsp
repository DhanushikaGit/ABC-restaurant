<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <!-- Add your stylesheet links here -->
    <style>
        /* Your existing CSS */
    </style>
</head>
<body>

<%@ include file="header.jsp" %>

<div class="confirmation-container">
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        BigDecimal total = new BigDecimal(request.getParameter("total"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment_method");
        String orderType = request.getParameter("order_type"); // New parameter
        int orderId = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            // Insert order into neworders table
            String insertSql = "INSERT INTO neworders (user_id, name, email, phone, address, payment_method, order_type) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, userId);
            pstmt.setString(2, name);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, paymentMethod);
            pstmt.setString(7, orderType); // Set order type
            pstmt.executeUpdate();

            // Retrieve the generated order ID
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Retrieve order items before clearing the cart
            String itemsSql = "SELECT c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
            pstmt = conn.prepareStatement(itemsSql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

    %>
    <div class="order-details">
        <h2>Order Details</h2>
        <p><strong>Order ID:</strong> <%= orderId %></p>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Order Type:</strong> <%= orderType %></p> <!-- Display order type -->
    </div>

    <div class="order-items">
        <h2>Order Items</h2>
    <%
            while (rs.next()) {
                BigDecimal price = rs.getBigDecimal("price");
                int quantity = rs.getInt("quantity");
                BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
    %>
    <div class="order-item">
        <img src="<%= request.getContextPath() + "/uploads/" + rs.getString("image") %>" alt="Food Image">
        <div class="order-item-details">
            <h3><%= rs.getString("name") %></h3>
            <p>Quantity: <%= quantity %></p>
        </div>
        <div class="order-item-price">
            $<%= itemTotal %>
        </div>
    </div>
    <%
            }
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    </div>
    <div class="order-total">
        Total: $<%= total %>
    </div>
    
    <%
        // Clear the cart after displaying order items
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            String deleteSql = "DELETE FROM cart WHERE user_id = ? AND status = 'pending'";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</div>
</body>
</html>
