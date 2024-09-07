<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Facility</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your CSS styles here */
        /* Basic reset */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

/* Body and container styling */
body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f4;
    color: #333;
    padding: 20px;
}

.page-header {
    text-align: center;
    margin-bottom: 20px;
}

h1 {
    font-size: 2em;
    color: #333;
}

/* Form styling */
form {
    background: #fff;
    padding: 20px;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    max-width: 600px;
    margin: auto;
}

label {
    display: block;
    font-weight: bold;
    margin-bottom: 8px;
}

input[type="text"], textarea, select, input[type="file"] {
    width: 100%;
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ddd;
    border-radius: 4px;
    font-size: 16px;
}

textarea {
    height: 100px;
}

input[type="file"] {
    padding: 0;
}

input[type="submit"] {
    background-color: #007bff;
    color: #fff;
    border: none;
    padding: 10px 20px;
    border-radius: 4px;
    font-size: 16px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
    background-color: #0056b3;
}

.facility-image {
    max-width: 100%;
    height: auto;
    border-radius: 4px;
    margin-bottom: 10px;
}

p {
    font-size: 14px;
    color: #666;
}
        
    </style>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Edit Facility</h1>
    </div>

    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            String sql = "SELECT id, name, description, status, image FROM facilities WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String name = rs.getString("name");
                String description = rs.getString("description");
                String status = rs.getString("status");
                String image = rs.getString("image");
    %>

    <form action="http://localhost:8090/restaurant/UpdateFacilityServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">

        <label for="name">Facility Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required><br><br>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description %></textarea><br><br>

        <label for="status">Status:</label>
        <select id="status" name="status" required>
            <option value="Available" <%= "Available".equals(status) ? "selected" : "" %>>Available</option>
            <option value="Unavailable" <%= "Unavailable".equals(status) ? "selected" : "" %>>Unavailable</option>
        </select><br><br>

        <label for="image">Image:</label>
        <input type="file" id="image" name="image" accept="image/*"><br><br>
        <% if (image != null && !image.isEmpty()) { %>
            <img src="<%= request.getContextPath() + "/uploads/" + image %>" alt="Facility Image" class="facility-image">
            <p>Current Image</p>
        <% } %>

        <input type="submit" value="Update Facility">
    </form>

    <%
            } else {
                out.println("<p>Facility not found.</p>");
            }
        } catch (Exception e) {
            out.println("<p>Error: " + e.getMessage() + "</p>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
  <%@ include file="adminfooter.jsp" %>
</html>
