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
<form action="Order_Details.jsp" method="get">
    <label for="searchName">Customer Name:</label>
    <input type="text" id="searchName" name="customer_name" value="<%= request.getParameter("customer_name") != null ? request.getParameter("customer_name") : "" %>">
    
    <label for="searchEmail">Customer Email:</label>
    <input type="text" id="searchEmail" name="customer_email" value="<%= request.getParameter("customer_email") != null ? request.getParameter("customer_email") : "" %>">
    
    <label for="searchDate">Order Date:</label>
    <input type="date" id="searchDate" name="order_date" value="<%= request.getParameter("order_date") != null ? request.getParameter("order_date") : "" %>">

    <label for="searchStatus">Order Status:</label>
    <select id="searchStatus" name="order_status">
        <option value="">Select Status</option>
        <option value="Confirm" <%= "Confirm".equals(request.getParameter("order_status")) ? "selected" : "" %>>Confirmed</option>
        <option value="Cancel" <%= "Cancel".equals(request.getParameter("order_status")) ? "selected" : "" %>>Canceled</option>
        <option value="Pending" <%= "Pending".equals(request.getParameter("order_status")) ? "selected" : "" %>>Pending</option>
    </select>

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
        <th>Status</th>
    </tr>

    <%
        mydb db = new mydb();
        Connection conn = db.getCon();
        if (conn != null) {
            // Prepare SQL query based on search parameters
            String customerName = request.getParameter("customer_name");
            String customerEmail = request.getParameter("customer_email");
            String orderDate = request.getParameter("order_date");
            String orderStatus = request.getParameter("order_status");
            
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
            if (orderStatus != null && !orderStatus.trim().isEmpty()) {
                sql.append(" AND action = ?");
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
                if (orderStatus != null && !orderStatus.trim().isEmpty()) {
                    pstmt.setString(index++, orderStatus);
                }
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("food_name") %></td>
        <td><%= rs.getBigDecimal("food_price") %></td>
        <td><%= rs.getString("order_type") %></td>
        <td><%= rs.getTimestamp("dine_in_time") != null ? rs.getTimestamp("dine_in_time").toString() : "N/A" %></td>
        <td><%= rs.getString("delivery_address") != null ? rs.getString("delivery_address") : "N/A" %></td>
        <td><%= rs.getString("meal_size") %></td>
        <td><%= rs.getString("meal_type") %></td>
        <td><%= rs.getString("customer_name") %></td>
        <td><%= rs.getString("customer_email") %></td>
        <td><%= rs.getString("customer_contact") %></td>
        <td><%= rs.getTimestamp("order_date") != null ? rs.getTimestamp("order_date").toString() : "N/A" %></td>
        <td><%= rs.getInt("meal_quantity") %></td>
        <td><%= rs.getBigDecimal("total_price") %></td>
        
        <td><%= rs.getString("action") %></td>
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
