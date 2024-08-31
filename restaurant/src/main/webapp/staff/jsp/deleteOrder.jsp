<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Delete Order</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .delete-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .delete-container h1 {
            font-size: 1.5rem;
            color: #333;
        }

        .delete-container p {
            color: #555;
        }

        .delete-container button {
            margin-top: 20px;
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .delete-container button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="delete-container">
        <h1>Delete Order</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            int orderId = Integer.parseInt(request.getParameter("orderId"));

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                // Delete the order
                String deleteSql = "DELETE FROM neworders WHERE order_id = ?";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, orderId);
                pstmt.executeUpdate();

                out.println("<p>Order deleted successfully.</p>");
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <form action="manageOrders.jsp">
            <button type="submit">Back to Orders</button>
        </form>
    </div>
</body>
</html>
