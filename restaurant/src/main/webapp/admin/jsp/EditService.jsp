\<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Service</title>
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

        .service-image {
            max-width: 200px;
            max-height: 200px;
            object-fit: cover;
        }
    </style>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Edit Service</h1>
        <small>Home / Edit Service</small>
    </div>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            String sql = "SELECT * FROM services WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
    %>
    <form action="<%= request.getContextPath() %>/UpdateServiceServlet" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
        <input type="text" name="name" value="<%= rs.getString("name") %>" placeholder="Service Name" required><br><br>
        <textarea name="description" placeholder="Description" required><%= rs.getString("description") %></textarea><br><br>
        <select name="status" required>
            <option value="Active" <%= rs.getString("status").equals("Active") ? "selected" : "" %>>Active</option>
            <option value="Inactive" <%= rs.getString("status").equals("Inactive") ? "selected" : "" %>>Inactive</option>
        </select><br><br>
        <input type="file" name="image" accept="image/*"><br><br>
        <% 
            String imagePath = rs.getString("image");
            String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                ? request.getContextPath() + "/uploads/" + imagePath 
                : "";
        %>
        <% if (!imageUrl.isEmpty()) { %>
            <img src="<%= imageUrl %>" alt="Service Image" class="service-image">
        <% } %>
        <input type="submit" value="Update Service">
    </form>
    <%
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</body>
  <%@ include file="adminfooter.jsp" %>
</html>
