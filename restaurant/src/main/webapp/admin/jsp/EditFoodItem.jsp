<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Food Item</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        form { max-width: 600px; margin: 0 auto; }
        label { display: block; margin-bottom: 5px; font-weight: bold; }
        input, textarea, select { width: 100%; padding: 8px; margin-bottom: 10px; }
        input[type="file"] { padding: 0; }
    </style>
</head>
<body>
    <h2>Edit Food Item</h2>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = "";
        String description = "";
        String price = "";
        String image = "";
        String category = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            String sql = "SELECT name, description, price, image, category FROM food_items WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                price = rs.getString("price");
                image = rs.getString("image");
                category = rs.getString("category");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        // Fetch categories for the dropdown
        String[] categories = {"Vegetable", "Non-Vegetable", "Beverage", "Unique"};
    %>
    <form action="<%= request.getContextPath() %>/EditFoodItemServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= id %>">
        
        <label for="name">Name:</label>
        <input type="text" id="name" name="name" value="<%= name %>" required>

        <label for="description">Description:</label>
        <textarea id="description" name="description" required><%= description %></textarea>

        <label for="price">Price:</label>
        <input type="text" id="price" name="price" value="<%= price %>" required>

        <label for="category">Category:</label>
        <select id="category" name="category" required>
            <% for (String cat : categories) { %>
                <option value="<%= cat %>" <%= cat.equals(category) ? "selected" : "" %>><%= cat %></option>
            <% } %>
        </select>

        <label for="image">Image:</label>
        <% if (image != null && !image.isEmpty()) { %>
            <img src="<%= request.getContextPath() %>/uploads/<%= image %>" alt="Food Image" style="max-width: 200px; max-height: 200px; margin-bottom: 10px;">
            <br>
            <span>Current image</span>
        <% } %>
        <input type="file" id="image" name="image" accept="image/*">

        <input type="submit" value="Update Food Item">
    </form>
</body>
</html>
