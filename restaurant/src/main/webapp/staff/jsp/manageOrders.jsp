<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Orders</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your styles here */
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

        .order {
            margin-bottom: 20px;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .order h2 {
            font-size: 1.5rem;
            color: #333;
        }

        .order p {
            margin: 5px 0;
            color: #555;
        }

        .order-items {
            margin-top: 10px;
        }

        .order-item {
            display: flex;
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

        .order-actions {
            margin-top: 10px;
        }

        .order-actions button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
        }

        .order-actions button:hover {
            background-color: #e68900;
        }
    </style>
</head>
<body>
    <div class="orders-container">
        <h1>Manage Orders</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT * FROM neworders ORDER BY order_date DESC";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                while (rs.next()) {
                    int orderId = rs.getInt("order_id");
                    String name = rs.getString("name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    String paymentMethod = rs.getString("payment_method");
                    Timestamp orderDate = rs.getTimestamp("order_date");
        %>
        <div class="order">
            <h2>Order ID: <%= orderId %></h2>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
            <p><strong>Order Date:</strong> <%= orderDate %></p>
            
            <div class="order-items">
                <h3>Items:</h3>
                <%
                    // Fetch order items for this order
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
            <div class="order-actions">
                <form action="updateOrder.jsp" method="post">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <button type="submit">Update Order</button>
                </form>
                <form action="deleteOrder.jsp" method="post" style="display:inline;">
                    <input type="hidden" name="orderId" value="<%= orderId %>">
                    <button type="submit">Delete Order</button>
                </form>
            </div>
        </div>
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
    </div>
</body>
</html>
