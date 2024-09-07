<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Staff Member</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
        /* Form Styling */
        form {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        form input[type="text"],
        form input[type="email"],
        form input[type="password"],
        form input[type="file"],
        form input[type="submit"] {
            width: calc(100% - 22px);
            padding: 10px;
            margin-bottom: 15px;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-sizing: border-box;
            font-size: 16px;
        }

        form input[type="submit"] {
            background-color: red;
            color: #fff;
            border: none;
            padding: 12px 20px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        form input[type="submit"]:hover {
            background-color: #FEA116;
            transform: scale(1.05);
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

       .page-header small {
           display: block; /* Block display for breadcrumb */
           color: #666; /* Gray color for breadcrumb */
           font-size: 0.9rem; /* Smaller font size */
           margin-top: 5px; /* Space above breadcrumb */
           font-style: italic; /* Italicize breadcrumb text */
       }
        
    </style>
</head>
<body>
<%@ include file="adminheader.jsp" %>
<div class="page-header">
    <h1>Manage Staff Details</h1>
    <small>Home / Edit Staff Details</small>
</div>


<%
    int id = Integer.parseInt(request.getParameter("id"));
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String name = "", email = "", position = "", image = "", password = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
        String sql = "SELECT name, email, position, image, password FROM staff WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setInt(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            position = rs.getString("position");
            image = rs.getString("image");
            password = rs.getString("password");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>

<!-- Edit Staff Form -->
<form action="http://localhost:8090/restaurant/EditStaffServlet" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= id %>">
    <label>Name:</label>
    <input type="text" name="name" value="<%= name %>" required>

    <label>Email:</label>
    <input type="email" name="email" value="<%= email %>" required>

    <label>Position:</label>
    <input type="text" name="position" value="<%= position %>" required>

    <label>Current Image:</label>
    <% if (image != null && !image.isEmpty()) { %>
        <img src="<%= request.getContextPath() + "/uploads/" + image %>" alt="Staff Image" style="max-width:100px;">
    <% } else { %>
        No Image Available
    <% } %>

    <label>New Image (optional):</label>
    <input type="file" name="image">

    <label>Password:</label>
    <input type="password" name="password" value="<%= password %>" required>

    <input type="submit" value="Update Staff Member">
</form>

</body>
  <%@ include file="adminfooter.jsp" %>
</html>
