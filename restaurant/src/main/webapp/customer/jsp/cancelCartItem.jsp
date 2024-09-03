<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    int cartId = Integer.parseInt(request.getParameter("cart_id"));
    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

        String sql = "DELETE FROM cart WHERE cart_id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, cartId);
        pstmt.executeUpdate();

        response.sendRedirect(request.getContextPath() + "http://localhost:8090/restaurant/customer/jsp/Cart.jsp"); // Redirect to the cart page
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
