<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Details</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .details-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .order-info {
            margin-bottom: 20px;
        }

        .order-info h1 {
            font-size: 1.8rem;
            color: #333;
        }

        .order-info p {
            margin: 5px 0;
            color: #555;
        }

        .order-items {
            margin-top: 20px;
        }

        .order-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 0;
            border-bottom: 1px solid #ddd;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-item img {
            max-width: 100px;
            border-radius: 8px;
        }

        .order-item-details {
            flex-grow: 1;
            margin-left: 20px;
        }

        .order-item-details h3 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }

        .order-item-details p {
            margin: 5px 0;
            color: #777;
        }

        .order-item-price {
            font-size: 1.1rem;
            color: #333;
        }

        .back-link {
            margin-top: 20px;
            display: inline-block;
            background-color: #FEA116;
            color: #fff;
            padding: 10px;
            border-radius: 4px;
            text-decoration: none;
        }

        .back-link:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="details-container">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String orderIdParam = request.getParameter("orderId");
            
            // Check if the orderId parameter is provided
            if (orderIdParam == null || orderIdParam.isEmpty()) {
                out.println("<p>Order ID is missing. Please go back and select an order.</p>");
                return;
            }
            
            int orderId;
            try {
                orderId = Integer.parseInt(orderIdParam);
            } catch (NumberFormatException e) {
                out.println("<p>Invalid Order ID format.</p>");
                return;
            }
            
            BigDecimal total = BigDecimal.ZERO;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                // Fetch order details
                String orderSql = "SELECT * FROM neworders WHERE order_id = ?";
                pstmt = conn.prepareStatement(orderSql);
                pstmt.setInt(1, orderId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String paymentMethod = rs.getString("payment_method");
                    Timestamp orderDate = rs.getTimestamp("order_date");
                    String status = rs.getString("status");
        %>
        <div class="order-info">
            <h1>Order ID: <%= orderId %></h1>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
            <p><strong>Order Date:</strong> <%= orderDate %></p>
            <p><strong>Status:</strong> <%= status %></p>
        </div>

        <div class="order-items">
            <h2>Order Items:</h2>
            <%
                // Fetch items for this order
                String itemsSql = "SELECT oi.quantity, f.name, f.price, f.image FROM order_items oi JOIN food_items f ON oi.food_id = f.id WHERE oi.order_id = ?";
                pstmt = conn.prepareStatement(itemsSql);
                pstmt.setInt(1, orderId);
                ResultSet itemsRs = pstmt.executeQuery();
                while (itemsRs.next()) {
                    BigDecimal price = itemsRs.getBigDecimal("price");
                    int quantity = itemsRs.getInt("quantity");
                    BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
                    total = total.add(itemTotal);
            %>
            <div class="order-item">
                <img src="<%= request.getContextPath() + "/uploads/" + itemsRs.getString("image") %>" alt="Food Image">
                <div class="order-item-details">
                    <h3><%= itemsRs.getString("name") %></h3>
                    <p>Quantity: <%= itemsRs.getInt("quantity") %></p>
                </div>
                <div class="order-item-price">
                    $<%= itemTotal %>
                </div>
            </div>
            <%
                }
                itemsRs.close();
            %>
        </div>

        <div class="order-total">
            <h2>Total: $<%= total %></h2>
        </div>

        <a href="manageOrders.jsp" class="back-link">Back to Orders</a>
        <%
                } else {
                    out.println("<p>No order found with ID: " + orderId + "</p>");
                }
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
</body>
</html>
