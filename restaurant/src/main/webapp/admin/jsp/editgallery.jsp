<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Gallery Item</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }

        .page-header {
            background-color: #ffffff;
            padding: 20px;
            border-bottom: 1px solid #ddd;
            margin-bottom: 20px;
        }

        .page-header h1 {
            margin: 0;
            font-size: 1.5rem;
            color: #333;
        }

        .page-header small {
            color: #888;
        }

        form {
            background-color: var(--light);
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
        }

        form input[type="text"], form textarea, form select, form input[type="file"] {
            width: 100%;
            border: 1px solid var(--dark);
            padding: 10px;
            border-radius: 4px;
            background-color: #fff;
            color: var(--dark);
            margin-bottom: 15px;
        }

        form textarea {
            height: 100px;
            resize: vertical;
        }

        form input[type="submit"] {
            background-color: var(--primary);
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        form input[type="submit"]:hover {
            background-color: #e68900;
        }

        .gallery-image {
            max-width: 150px;
            max-height: 150px;
            object-fit: cover;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Edit Gallery Item</h1>
        <small>Home / Edit Gallery</small>
    </div>
   <%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    String title = "";
    String description = "";
    String image = "";
    String category = "";  // Added this line to store the category

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

        String sql = "SELECT title, description, image, category FROM gallery WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();
        if (rs.next()) {
            title = rs.getString("title");
            description = rs.getString("description");
            image = rs.getString("image");
            category = rs.getString("category");  // Added this line to populate the category variable
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<form action="<%= request.getContextPath() %>/EditGalleryServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= id %>">
    <input type="text" name="title" value="<%= title %>" placeholder="Title" required><br><br>
    <textarea name="description" placeholder="Description" required><%= description %></textarea><br><br>
    
    <!-- Category Dropdown -->
    <select name="category" required>
        <option value="Category1" <%= "Category1".equals(category) ? "selected" : "" %>>Category1</option>
        <option value="Category2" <%= "Category2".equals(category) ? "selected" : "" %>>Category2</option>
        <!-- Add more categories as needed -->
    </select><br><br>

    <% if (image != null && !image.isEmpty()) { %>
        <img src="<%= request.getContextPath() %>/gallery_uploads/<%= image %>" alt="Gallery Image" class="gallery-image">
        <br><br>
    <% } %>
    <input type="file" name="image" accept="image/*"><br><br>
    <input type="submit" value="Update Gallery Item">
</form>
   
 
</html>
