<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Food Item</title>
<style>
        body {
            font-family: 'Arial', sans-serif; /* Basic font family */
            margin: 0; /* Remove default margin */
            padding: 0; /* Remove default padding */
            background-color: #f4f4f4; /* Light gray background */
        }

      /* Page header styling */
.page-header {
    background-color: #ffffff; /* White background for the header */
    padding: 20px; /* Padding inside the header */
    border-bottom: 1px solid #ddd; /* Light border at the bottom */
    margin-bottom: 20px; /* Space below the header */
}

.page-header h1 {
    margin: 0; /* Remove default margin */
    font-size: 1.5rem; /* Larger font size for the title */
    color: #333; /* Dark gray color */
}

.page-header small {
    color: #888; /* Light gray color for the breadcrumb */
}
      
        form {
            background-color: #ffffff; /* White background for the form */
            padding: 20px; /* Padding */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Shadow for depth */
            max-width: 600px; /* Max width */
            margin: 20px auto; /* Centered horizontally */
        }

        form label {
            display: block; /* Block display */
            margin-bottom: 8px; /* Space below each label */
            font-weight: bold; /* Bold labels */
            color: #333; /* Dark text color */
        }

        form input[type="text"],
        form textarea,
        form select {
            width: 100%; /* Full width */
            padding: 8px; /* Padding inside inputs */
            margin-bottom: 16px; /* Space below each input */
            border: 1px solid #ddd; /* Light border */
            border-radius: 4px; /* Rounded corners */
            box-sizing: border-box; /* Include padding and border in the width and height */
            font-size: 16px; /* Font size */
        }

        form input[type="submit"] {
            background-color: black; /* Button background color */
            color: #fff; /* White text */
            border: none; /* Remove border */
            padding: 12px 20px; /* Padding inside button */
            font-size: 16px; /* Font size */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor */
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        form input[type="submit"]:hover {
            background-color: #e68900; /* Hover background color */
        }

        form img {
            max-width: 200px; /* Max width */
            max-height: 200px; /* Max height */
            display: block; /* Block display */
            margin-bottom: 10px; /* Space below the image */
        }

        form span {
            display: block; /* Block display */
            margin-bottom: 10px; /* Space below the span */
            color: #666; /* Darker gray color */
            font-size: 14px; /* Font size */
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this food item?');
        }
    </script>
       
</head>
<body>
  <%@ include file="adminheader.jsp" %>
    <div class="page-header">
                <h1>Manage Food Item</h1>
                <small>Home / Manage Food Item</small>
            </div>
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
  <%@ include file="adminfooter.jsp" %>
</html>
