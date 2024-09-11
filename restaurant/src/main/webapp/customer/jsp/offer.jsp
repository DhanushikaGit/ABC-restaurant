<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.DriverManager, java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Offer Page</title>
</head>
<body>
  <!-- Offer Page Start -->
<div class="gallery-grid">
<%
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

        String sql = "SELECT id, title, image FROM gallery WHERE category = 'Offer'";
        pstmt = conn.prepareStatement(sql);

        rs = pstmt.executeQuery();

        if (!rs.isBeforeFirst()) { // If result set is empty, show a default placeholder
%>
        <div class="gallery-item">
            <img src="<%= request.getContextPath() %>/uploads/default.png" alt="No Offer Available">
            <div class="gallery-item-title">No Offers Available</div>
        </div>
<%
        } else {
            while (rs.next()) {
                String title = rs.getString("title");
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + imagePath 
                    : request.getContextPath() + "/uploads/default.png";
%>
    <div class="gallery-item">
        <img src="<%= imageUrl %>" alt="Offer Image">
        <div class="gallery-item-title"><%= title %></div>
    </div>
<%
            }
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
</div>
<!-- Offer Page End -->

</body>
</html>
