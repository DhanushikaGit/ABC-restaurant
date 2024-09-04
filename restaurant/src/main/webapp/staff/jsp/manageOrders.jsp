<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link rel="stylesheet" href="/restaurant/admin/css/admin.css" />
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <title>ABC Restaurant - Manage Orders</title>
    <style>
        #sidebar-wrapper {
            background-color: #ffffff; /* Set sidebar background color to white */
        }
        #page-content-wrapper {
            background-color: #ffffff; /* Set page content background color to white */
        }
        .list-group-item.active {
            background-color: #f8f9fa; /* Slightly different background for active item */
        }
        .sidebar-heading {
            background-color: #ffffff; /* Set sidebar heading background color to white */
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
    
    <%@ include file="staffheader.jsp" %>

       

                <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item dropdown">
                            <a class="nav-link dropdown-toggle second-text fw-bold" href="#" id="navbarDropdown"
                                role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                <i class="fas fa-user me-2"></i>Staff Name
                            </a>
                            <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                                <li><a class="dropdown-item" href="/restaurant/staff/jsp/profile.jsp">Profile</a></li>
                                <li><a class="dropdown-item" href="/restaurant/admin/jsp/adminLogin.jsp">Logout</a></li>
                            </ul>
                        </li>
                    </ul>
                </div>
            </nav>

            <!-- Orders Content -->
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
        </div>
        <!-- /#page-content-wrapper -->
    </div>
    <!-- /#wrapper -->

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.1/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta3/dist/js/bootstrap.min.js"></script>
    <script>
        var el = document.getElementById("wrapper");
        var toggleButton = document.getElementById("menu-toggle");

        toggleButton.onclick = function () {
            el.classList.toggle("toggled");
        };
    </script>
</body>
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</html>
