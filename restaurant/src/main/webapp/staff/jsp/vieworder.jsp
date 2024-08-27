<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Orders</title>
    <style>
        .btn { padding: 5px 10px; border: none; cursor: pointer; }
        .btn-success { background-color: #28a745; color: #fff; }
        .btn-danger { background-color: #dc3545; color: #fff; }
        .btn-warning { background-color: #ffc107; color: #000; }
        .btn-primary { background-color: #007bff; color: #fff; }
    </style>
</head>
<body>

<h2>Orders</h2>

<!-- Search Form -->
<form action="vieworder.jsp" method="get">
    <label for="searchName">Customer Name:</label>
    <input type="text" id="searchName" name="customer_name" value="<%= request.getParameter("customer_name") != null ? request.getParameter("customer_name") : "" %>">
    
    <label for="searchEmail">Customer Email:</label>
    <input type="text" id="searchEmail" name="customer_email" value="<%= request.getParameter("customer_email") != null ? request.getParameter("customer_email") : "" %>">
    
    <label for="searchDate">Order Date:</label>
    <input type="date" id="searchDate" name="order_date" value="<%= request.getParameter("order_date") != null ? request.getParameter("order_date") : "" %>">
    
    <input type="submit" value="Search" class="btn btn-primary">
</form>

<table border="1">
    <tr>
        <th>Food Name</th>
        <th>Food Price</th>
        <th>Order Type</th>
        <th>Dine-In Time</th>
        <th>Delivery Address</th>
        <th>Meal Size</th>
        <th>Meal Type</th>
        <th>Customer Name</th>
        <th>Customer Email</th>
        <th>Customer Contact</th>
        <th>Order Date</th>
        <th>Quantity</th>
        <th>Total Price</th>
        <th>Action</th>
    </tr>

    <%
        mydb db = new mydb();
        Connection conn = db.getCon();
        if (conn != null) {
            // Prepare SQL query based on search parameters
            String customerName = request.getParameter("customer_name");
            String customerEmail = request.getParameter("customer_email");
            String orderDate = request.getParameter("order_date");
            
            StringBuilder sql = new StringBuilder("SELECT * FROM orders WHERE 1=1");
            if (customerName != null && !customerName.trim().isEmpty()) {
                sql.append(" AND customer_name LIKE ?");
            }
            if (customerEmail != null && !customerEmail.trim().isEmpty()) {
                sql.append(" AND customer_email LIKE ?");
            }
            if (orderDate != null && !orderDate.trim().isEmpty()) {
                sql.append(" AND DATE(order_date) = ?");
            }
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
                int index = 1;
                if (customerName != null && !customerName.trim().isEmpty()) {
                    pstmt.setString(index++, "%" + customerName + "%");
                }
                if (customerEmail != null && !customerEmail.trim().isEmpty()) {
                    pstmt.setString(index++, "%" + customerEmail + "%");
                }
                if (orderDate != null && !orderDate.trim().isEmpty()) {
                    pstmt.setString(index++, orderDate);
                }
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("food_name") %></td>
        <td><%= rs.getBigDecimal("food_price") %></td>
        <td><%= rs.getString("order_type") %></td>
        <td><%= rs.getTimestamp("dine_in_time") %></td>
        <td><%= rs.getString("delivery_address") %></td>
        <td><%= rs.getString("meal_size") %></td>
        <td><%= rs.getString("meal_type") %></td>
        <td><%= rs.getString("customer_name") %></td>
        <td><%= rs.getString("customer_email") %></td>
        <td><%= rs.getString("customer_contact") %></td>
        <td><%= rs.getTimestamp("order_date") %></td>
        <td><%= rs.getInt("meal_quantity") %></td>
        <td><%= rs.getBigDecimal("total_price") %></td>
        <td>
            <form action="http://localhost:8090/restaurant/staff/jsp/EditOrder.jsp" method="get" style="display:inline;">
                <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Edit" class="btn btn-primary">
            </form>
            <form action="http://localhost:8090/restaurant/ConfirmOrderServlet" method="post" style="display:inline;">
                <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Confirm" class="btn btn-success">
            </form>
            <form action="http://localhost:8090/restaurant/CancelOrderServlet" method="post" style="display:inline;">
                <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Cancel" class="btn btn-danger">
            </form>
            <form action="http://localhost:8090/restaurant/PendingOrderServlet" method="post" style="display:inline;">
                <input type="hidden" name="order_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Pending" class="btn btn-warning">
            </form>
        </td>
    </tr>
    <%
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</table>

</body>
</html>
