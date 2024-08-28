<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.io.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Services</title>
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

        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        th {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
            background-color: #f1f1f1;
        }

        td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: left;
        }

        tr:hover {
            background-color: #f9f9f9;
        }

        .service-image {
            max-width: 100px;
            max-height: 100px;
            object-fit: cover;
        }

        .edit-button, .delete-button {
            padding: 5px 10px;
            border: none;
            color: #fff;
            cursor: pointer;
            border-radius: 4px;
            font-size: 14px;
        }

        .edit-button {
            background-color: var(--primary);
        }

        .edit-button:hover {
            background-color: #e68900;
        }

        .delete-button {
            background-color: #f44336;
        }

        .delete-button:hover {
            background-color: #e53935;
        }

        table td[colspan='6'] {
            color: #f44336;
            text-align: center;
            padding: 20px;
        }
    </style>
    <script>
        function confirmDelete() {
            return confirm('Are you sure you want to delete this service?');
        }
    </script>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Manage Services</h1>
        <small>Home / Manage Services</small>
    </div>
    <form action="http://localhost:8090/restaurant/AddServiceServlet" method="post" enctype="multipart/form-data">
        <input type="text" name="name" placeholder="Service Name" required><br><br>
        <textarea name="description" placeholder="Description" required></textarea><br><br>
        <select name="status" required>
            <option value="Active">Active</option>
            <option value="Inactive">Inactive</option>
        </select><br><br>
        <input type="file" name="image" accept="image/*"><br><br>
        <input type="submit" value="Add Service">
    </form>

    <form action="http://localhost:8090/restaurant/admin/jsp/manageServices.jsp" method="get" class="search-form">
        <input type="search" name="searchQuery" placeholder="Search" class="record-search">
        <select name="searchField">
            <option value="name">Name</option>
            <option value="description">Description</option>
            <option value="status">Status</option>
        </select>
        <button type="submit">Search</button>
    </form>

    <br>
    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Description</th>
            <th>Status</th>
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

                String sql = "SELECT id, name, description, status, image FROM services";
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
            <td><%= rs.getString("status") %></td>
            <td>
                <% 
                    String imagePath = rs.getString("image");
                    String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
                        ? request.getContextPath() + "/uploads/" + imagePath 
                        : ""; 
                %>
                <% if (!imageUrl.isEmpty()) { %>
                    <img src="<%= imageUrl %>" alt="Service Image" class="service-image">
                <% } else { %>
                    No Image
                <% } %>
            </td>
            <td>
                <form action="http://localhost:8090/restaurant/admin/jsp/EditService.jsp" method="get" style="display:inline;">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="edit-button"><i class="las la-edit"></i></button>
                </form>
                <form action="http://localhost:8090/restaurant/DeleteServiceServlet" method="post" style="display:inline;" onsubmit="return confirmDelete();">
                    <input type="hidden" name="id" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="delete-button"><i class="las la-trash"></i></button>
                </form>
            </td>
        </tr>
        <%
                }
            } catch (Exception e) {
                out.println("<tr><td colspan='6'>Error: " + e.getMessage() + "</td></tr>");
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </table>
</body>
</html>
