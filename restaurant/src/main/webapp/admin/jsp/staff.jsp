<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ABC Restaurant Manage Staff</title>
     
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
    :root {
        --primary: #FEA116; /* Primary color */
        --light: #F1F8FF;   /* Light color */
        --dark: #0F172B;    /* Dark color */
    }
    
       /* General Body Styling */
       body {
           font-family: Arial, sans-serif;
           background-color: #f8f9fa; /* Light gray background */
           color: #333; /* Dark text color */
           margin: 0;
           padding: 0;
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

       /* Form Styling */
       form {
           max-width: 600px; /* Maximum width of the form */
           margin: 20px auto; /* Center form horizontally */
           padding: 20px; /* Padding inside the form */
           background-color: #ffffff; /* White background */
           border-radius: 8px; /* Rounded corners */
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
       }

       form input[type="text"],
       form input[type="email"],
       form input[type="password"],
       form input[type="file"],
       form input[type="submit"] {
           width: calc(100% - 22px); /* Full width minus padding and border */
           padding: 10px; /* Padding inside inputs */
           margin-bottom: 15px; /* Space below each input */
           border: 1px solid #ddd; /* Light border */
           border-radius: 4px; /* Rounded corners */
           box-sizing: border-box; /* Include padding and border in total width */
           font-size: 16px; /* Font size */
       }

       form input[type="submit"] {
           background-color: var(--primary); /* Blue background */
           color: black; /* White text color */
           border: 1px solid black; /* Remove default border */
           padding: 12px 20px; /* Padding inside button */
           font-size: 16px; /* Font size */
           cursor: pointer; /* Pointer cursor on hover */
           transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
       }

       form input[type="submit"]:hover {
           background-color: white; /* Darker blue on hover */
           transform: scale(1.05); /* Slightly enlarge button on hover */
       }

       /* Table Styling */
       table {
           width: 100%; /* Full width of the container */
           border-collapse: collapse; /* Collapse table borders */
           margin-bottom: 20px; /* Space below table */
           box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow */
           border-radius: 8px; /* Rounded corners */
           overflow: hidden; /* Ensure no overflow */
       }

       table, th, td {
           border: 1px solid #ddd; /* Border for table and cells */
       }

       th, td {
           padding: 10px; /* Padding inside cells */
           text-align: left; /* Align text to the left */
       }

       th {
           background-color: #f2f2f2; /* Light gray background for headers */
       }

       /* Image Styling */
       .staff-image {
           max-width: 100px; /* Limit width of images */
           max-height: 100px; /* Limit height of images */
           object-fit: cover; /* Ensure image covers area without distortion */
       }

       /* Button Styling */
       .delete-button {
           color: white;
           background-color: #FEA116; /* Red background */
           padding: 5px 10px; /* Padding inside button */
           text-decoration: none; /* Remove underline */
           border-radius: 5px; /* Rounded corners */
           border: none; /* Remove default border */
           cursor: pointer; /* Pointer cursor on hover */
           font-size: 14px; /* Font size */
           transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
       }

       .delete-button:hover {
           background-color: #c82333; /* Darker red on hover */
           transform: scale(1.05); /* Slightly enlarge button on hover */
       }

       .add-button {
           color: black;
         background-color:  #F1F8FF;
           padding: 5px 10px; /* Padding inside button */
           text-decoration: none; /* Remove underline */
           border-radius: 5px; /* Rounded corners */
           border: none; /* Remove default border */
           cursor: pointer; /* Pointer cursor on hover */
           font-size: 14px; /* Font size */
           transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
       }

       .add-button:hover {
           background-color:white; /* Red on hover */
           transform: scale(1.05); /* Slightly enlarge button on hover */
       }
    </style>
</head>
<body>

<%@ include file="adminheader.jsp" %>
<div class="page-header">
    <h1>Manage Staff Details</h1>
    <small>Home / Manage Staff Details</small>
</div>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this staff member?");
    }
</script>

<!-- Search Form -->
<form action="http://localhost:8090/restaurant/admin/jsp/staff.jsp" method="get">
    <input type="text" name="search" placeholder="Search by Name, Email or Position" value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
    <input type="submit" value="Search" class="add-button">
</form>

<!-- Add Staff Form -->
<form action="http://localhost:8090/restaurant/AddStaffServlet" method="post" enctype="multipart/form-data">
    <input type="text" name="name" placeholder="Name" required>
    <input type="email" name="email" placeholder="Email" required>
    <input type="text" name="position" placeholder="Position" required>
    <input type="file" name="image" accept="image/*" required>
    <input type="password" name="password" placeholder="Password" required>
    <input type="submit" value="Add Staff" class="add-button">
</form>

<!-- Staff Table -->
<!-- Staff Table -->
<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Position</th>
        <th>Image</th>
        <th>Password</th>
        <th>Action</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        String search = request.getParameter("search");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            stmt = conn.createStatement();

            // Modify SQL query based on search input
            String sql = "SELECT id, name, email, position, image, password FROM staff";
            if (search != null && !search.trim().isEmpty()) {
                sql += " WHERE name LIKE '%" + search + "%' OR email LIKE '%" + search + "%' OR position LIKE '%" + search + "%'";
            }

            rs = stmt.executeQuery(sql);
            while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getInt("id") %></td>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("position") %></td>
        <td>
            <%
                String imagePath = rs.getString("image");
                String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                    ? request.getContextPath() + "/uploads/" + imagePath 
                    : ""; 
            %>
            <% if (!imageUrl.isEmpty()) { %>
                <img src="<%= imageUrl %>" alt="Staff Image" class="staff-image">
            <% } else { %>
                No Image
            <% } %>
        </td>
        <td><%= rs.getString("password") %></td>
        <td>
            <!-- Edit button -->
            <form action="editstaff.jsp" method="get" style="display:inline;">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Edit" class="edit-button">
            </form>

            <!-- Delete button -->
            <form action="http://localhost:8090/restaurant/DeleteStaffServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
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
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</table>


</body>
  <%@ include file="adminfooter.jsp" %>
</html>
