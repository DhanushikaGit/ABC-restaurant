<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        :root {
            --primary: #FEA116; /* Primary color */
            --light: #F1F8FF;   /* Light color */
            --dark: #0F172B;    /* Dark color */
        }

        body {
            font-family: Arial, sans-serif; /* Basic font family */
            margin: 0; /* Remove default margin */
            padding: 0; /* Remove default padding */
            background-color: #f4f4f4; /* Light gray background */
        }

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

        .orders-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
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
            background-color: #f4f4f4;
        }

        tr:hover {
            background-color: #f9f9f9; /* Light gray background on hover */
        }

        .order-item img {
            max-width: 50px;
            border-radius: 8px;
        }

        .order-actions button {
            background-color: var(--primary); /* Primary color */
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .order-actions button:hover {
            background-color: #e68900;
        }

        /* Search Form Styling */
        .search-container {
            margin-bottom: 20px;
        }

        .search-container input[type="text"] {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 200px;
        }

        .search-container button {
            padding: 10px 15px;
            border: none;
            background-color: var(--primary); /* Primary color */
            color: #fff;
            border-radius: 4px;
            cursor: pointer;
        }

        .search-container button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <%@ include file="adminheader.jsp" %>
    <div class="page-header">
        <h1>Manage Orders</h1>
        <small>Admin Panel</small>
    </div>
        
    <div class="orders-container">
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
  <%@ include file="adminfooter.jsp" %>
</html>
