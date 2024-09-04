<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Update Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .update-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .update-container h1 {
            font-size: 1.5rem;
            color: #333;
        }

        .update-container form {
            display: flex;
            flex-direction: column;
        }

        .update-container label {
            margin: 10px 0 5px;
            color: #555;
        }

        .update-container select, .update-container button {
            padding: 10px;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .update-container button {
            margin-top: 20px;
            background-color: #FEA116;
            color: #fff;
            border: none;
            cursor: pointer;
        }

        .update-container button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="update-container">
        <h1>Update Order Status</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            String status = request.getParameter("status");

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                if (status != null) {
                    // Update order status
                    String updateSql = "UPDATE neworders SET status = ? WHERE order_id = ?";
                    pstmt = conn.prepareStatement(updateSql);
                    pstmt.setString(1, status);
                    pstmt.setInt(2, orderId);
                    pstmt.executeUpdate();
                    
                    out.println("<p>Order status updated successfully.</p>");
                } else {
                    // Fetch current status to display in the form
                    String fetchSql = "SELECT status FROM neworders WHERE order_id = ?";
                    pstmt = conn.prepareStatement(fetchSql);
                    pstmt.setInt(1, orderId);
                    rs = pstmt.executeQuery();
                    if (rs.next()) {
                        String currentStatus = rs.getString("status");
        %>
        <form action="updateOrder.jsp" method="post">
            <input type="hidden" name="orderId" value="<%= orderId %>">
            <label for="status">Order Status:</label>
            <select name="status" id="status">
                <option value="Pending" <%= "Pending".equals(currentStatus) ? "selected" : "" %>>Pending</option>
                <option value="Processing" <%= "Processing".equals(currentStatus) ? "selected" : "" %>>Processing</option>
                <option value="Completed" <%= "Completed".equals(currentStatus) ? "selected" : "" %>>Completed</option>
                <option value="Cancelled" <%= "Cancelled".equals(currentStatus) ? "selected" : "" %>>Cancelled</option>
            </select>
            <button type="submit">Update Status</button>
        </form>
        <%
                    }
                    rs.close();
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <form action="manageOrders.jsp">
            <button type="submit">Back to Orders</button>
        </form>
    </div>
</body>
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</html>
