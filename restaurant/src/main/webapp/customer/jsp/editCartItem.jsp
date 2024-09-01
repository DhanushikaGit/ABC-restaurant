<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.IOException" %>
<%
    int cartId = -1;
    int newQuantity = -1;
    boolean error = false;
    
    // Retrieve parameters and handle potential null values
    String cartIdStr = request.getParameter("cart_id");
    String quantityStr = request.getParameter("quantity");
    
    if (cartIdStr != null && !cartIdStr.trim().isEmpty()) {
        try {
            cartId = Integer.parseInt(cartIdStr);
        } catch (NumberFormatException e) {
            error = true;
            out.println("Invalid cart ID.");
        }
    } else {
        error = true;
        out.println("Cart ID is missing.");
    }
    
    if (quantityStr != null && !quantityStr.trim().isEmpty()) {
        try {
            newQuantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            error = true;
            out.println("Invalid quantity.");
        }
    } else {
        error = true;
        out.println("Quantity is missing.");
    }

    if (error) {
        // Stop further processing if there's an error
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

        String sql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, newQuantity);
        pstmt.setInt(2, cartId);
        pstmt.executeUpdate();

        response.sendRedirect("/restaurant/customer/jsp/Cart.jsp"); // Redirect to the cart page
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
