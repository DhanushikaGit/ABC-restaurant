<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Staff</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            padding: 20px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ddd;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .delete-button {
            color: white;
            background-color: red;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .add-button {
            color: white;
            background-color: green;
            padding: 5px 10px;
            text-decoration: none;
            border-radius: 5px;
            border: none;
            cursor: pointer;
        }
        .staff-image {
            max-width: 100px; /* Adjust size as needed */
            max-height: 100px; /* Adjust size as needed */
            object-fit: cover;
        }
    </style>
</head>
<body>


<jsp:include page="header.jsp"></jsp:include>

<script>
    function confirmDelete() {
        return confirm("Are you sure you want to delete this staff member?");
    }
</script>

    <h2>Manage Staff</h2>
    <form action="http://localhost:8090/restaurant/AddStaffServlet" method="post" enctype="multipart/form-data">
        <input type="text" name="name" placeholder="Name" required>
        <input type="email" name="email" placeholder="Email" required>
        <input type="text" name="position" placeholder="Position" required>
        <input type="file" name="image" accept="image/*" required>
        <input type="password" name="password" placeholder="Password" required>
        <input type="submit" value="Add Staff" class="add-button">
    </form>
    
    <table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Position</th>
        <th>Image</th>
        <th>Password</th> <!-- New Password Column -->
        <th>Action</th>
    </tr>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            stmt = conn.createStatement();
            String sql = "SELECT id, name, email, position, image, password FROM staff"; // Include password
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
        <td><%= rs.getString("password") %></td> <!-- Display Password -->
        <td>
            <form action="http://localhost:8090/restaurant/DeleteStaffServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Delete" class="delete-button">
            </form>
        </td>
    </tr>
    <%
            }
        } catch (Exception e) {
            out.println("<tr><td colspan='7'>Error: " + e.getMessage() + "</td></tr>"); // Adjust colspan
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</table>
    
</body>
</html>
