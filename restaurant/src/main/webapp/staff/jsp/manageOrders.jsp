<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .orders-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        h1 {
            color: #333;
            margin-bottom: 20px;
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
            padding: 12px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        .order-actions button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 8px 12px;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-right: 5px;
        }

        .order-actions button:hover {
            background-color: #e68900;
        }

        .order-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
        }

        .order-item img {
            max-width: 60px;
            border-radius: 8px;
            margin-right: 10px;
        }

        .order-item div {
            font-size: 14px;
        }

        .search-container {
            margin-bottom: 20px;
        }

        .search-container input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 250px;
        }

        .search-container button {
            padding: 10px 15px;
            border: none;
            background-color: #FEA116;
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
            font-size: 14px;
            margin-left: 10px;
        }

        .search-container button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="orders-container">
        <h1>Manage Orders</h1>
        
        <!-- Search Form -->
        <div class="search-container">
            <form method="get" action="">
                <input type="text" name="search" placeholder="Search by name or email" value="<%= request.getParameter("search") %>">
                <button type="submit">Search</button>
            </form>
        </div>
        
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Payment Method</th>
                    <th>Order Date</th>
                    <th>Status</th>
                    <th>Items</th>
                    <th>Order Type</th> <!-- New column -->
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                    // Get search parameter
                    String search = request.getParameter("search");
                    search = (search != null) ? "%" + search + "%" : "%";

                    // Modify SQL query based on search parameter
                    String sql = "SELECT * FROM neworders WHERE name LIKE ? OR email LIKE ? ORDER BY order_date DESC";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setString(1, search);
                    pstmt.setString(2, search);
                    rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int orderId = rs.getInt("order_id");
                        String name = rs.getString("name");
                        String email = rs.getString("email");
                        String phone = rs.getString("phone");
                        String address = rs.getString("address");
                        String paymentMethod = rs.getString("payment_method");
                        Timestamp orderDate = rs.getTimestamp("order_date");
                        String orderType = rs.getString("order_type"); // Retrieve order_type
                        String status = rs.getString("status");
            %>
                <tr>
                    <td><%= orderId %></td>
                    <td><%= name %></td>
                    <td><%= email %></td>
                    <td><%= phone %></td>
                    <td><%= address %></td>
                    <td><%= paymentMethod %></td>
                    <td><%= orderDate %></td>
                    <td><%= status %></td>
                    <td>
                        <%
                            // Fetch items for this order
                            String itemsSql = "SELECT c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
                            pstmt = conn.prepareStatement(itemsSql);
                            pstmt.setInt(1, rs.getInt("user_id"));
                            ResultSet itemsRs = pstmt.executeQuery();
                            while (itemsRs.next()) {
                                BigDecimal price = itemsRs.getBigDecimal("price");
                                int quantity = itemsRs.getInt("quantity");
                                BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
                        %>
                        <div class="order-item">
                            <img src="<%= request.getContextPath() + "/uploads/" + itemsRs.getString("image") %>" alt="Food Image">
                            <div>
                                <%= itemsRs.getString("name") %> (Qty: <%= quantity %>, Total: $<%= itemTotal %>)
                            </div>
                        </div>
                        <%
                            }
                            itemsRs.close();
                        %>
                    </td>
                    <td><%= orderType %></td> <!-- Display order_type -->
                    <td class="order-actions">
                        <form action="/restaurant/staff/jsp/updateOrder.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="orderId" value="<%= orderId %>">
                            <button type="submit">Update</button>
                        </form>
                        <form action="/restaurant/staff/jsp/deleteOrder.jsp" method="post" style="display:inline;">
                            <input type="hidden" name="orderId" value="<%= orderId %>">
                            <button type="submit">Delete</button>
                        </form>
                    </td>
                </tr>
            <%
                    }
                } catch (Exception e) {
                    out.println("Error: " + e.getMessage());
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
            </tbody>
        </table>
    </div>
</body>
</html>
