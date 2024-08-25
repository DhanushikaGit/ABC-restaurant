<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Food Items</title>
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        table { width: 100%; border-collapse: collapse; margin-bottom: 20px; }
        table, th, td { border: 1px solid #ddd; }
        th, td { padding: 10px; text-align: left; }
        th { background-color: #f2f2f2; }
        .edit-button, .delete-button { padding: 5px 10px; border: none; cursor: pointer; }
        .edit-button { background-color: #4CAF50; color: white; }
        .delete-button { background-color: #f44336; color: white; }
        .food-image { max-width: 100px; max-height: 100px; object-fit: cover; }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this food item?');
        }
    </script>
</head>
<body>


   <h2>Add Food Item</h2>
<form action="http://localhost:8090/restaurant/AddFoodItemServlet" method="post" enctype="multipart/form-data">
    <input type="text" name="name" placeholder="Food Name" required><br><br>
    <textarea name="description" placeholder="Description" required></textarea><br><br>
    <input type="text" name="price" placeholder="Price" required><br><br>
    <select name="category" required>
        <option value="Vegetables">Vegetables</option>
        <option value="Non-Vegetables">Non-Vegetables</option>
        <option value="Beverages">Beverages</option>
        <option value="Unique Dishes">Unique Dishes</option>
    </select><br><br>
    <input type="file" name="image" accept="image/*"><br><br>
    <input type="submit" value="Add Food Item">
</form>
   

   <h2>Manage Food Items</h2>
<form action="http://localhost:8090/restaurant/admin/jsp/AddFoodItem.jsp" method="get">
    <input type="search" name="searchQuery" placeholder="Search" class="record-search">
    <select name="searchField">
        <option value="name">Name</option>
        <option value="description">Description</option>
        <option value="price">Price</option>
        <option value="category">Category</option>
    </select>
    <button type="submit">Search</button>
</form>
<br>
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Category</th>
        <th>Image</th>
        <th>Actions</th>
    </tr>
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String searchQuery = request.getParameter("searchQuery");
        String searchField = request.getParameter("searchField");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            String sql = "SELECT id, name, description, price, category, image FROM food_items";
            if (searchQuery != null && !searchQuery.trim().isEmpty() && searchField != null) {
                sql += " WHERE " + searchField + " LIKE ?";
            }

            pstmt = conn.prepareStatement(sql);
            if (searchQuery != null && !searchQuery.trim().isEmpty() && searchField != null) {
                pstmt.setString(1, "%" + searchQuery + "%");
            }

            rs = pstmt.executeQuery();
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("description") %></td>
        <td><%= rs.getBigDecimal("price") %></td>
        <td><%= rs.getString("category") %></td>
        <td>
            <% 
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + imagePath 
                    : ""; 
            %>
            <% if (!imageUrl.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="Food Image" class="food-image">
            <% } else { %>
                No Image
            <% } %>
        </td>
        <td>
            <form action="http://localhost:8090/restaurant/admin/jsp/EditFoodItem.jsp" method="get" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Edit" class="edit-button">
            </form>
            <form action="http://localhost:8090/restaurant/DeleteFoodItemServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Delete" class="delete-button">
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</table>
   

</body>
</html>
