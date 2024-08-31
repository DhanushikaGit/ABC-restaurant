<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .checkout-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .checkout-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }

        .checkout-item:last-child {
            border-bottom: none;
        }

        .checkout-item img {
            max-width: 100px;
            border-radius: 8px;
        }

        .checkout-item-details {
            flex-grow: 1;
            margin-left: 20px;
        }

        .checkout-item-details h3 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }

        .checkout-item-details p {
            margin: 5px 0;
            color: #777;
        }

        .checkout-item-price {
            font-size: 1.1rem;
            color: #333;
        }

        .checkout-total {
            text-align: right;
            font-size: 1.5rem;
            margin-top: 20px;
            color: #333;
        }

        .checkout-form {
            margin-top: 20px;
        }

        .checkout-form input, .checkout-form textarea, .checkout-form select {
            width: 100%;
            padding: 10px;
            margin: 5px 0;
            border-radius: 4px;
            border: 1px solid #ddd;
        }

        .checkout-form button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .checkout-form button:hover {
            background-color: #e68900;
        }

    </style>
</head>
<body>
    <div class="checkout-container">
        <h1>Checkout</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int userId = 1; // Replace with session-based user ID
            BigDecimal total = BigDecimal.ZERO;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT c.quantity, f.name, f.price FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
        %>
        <div class="checkout-items">
        <%
                while (rs.next()) {
                    BigDecimal price = rs.getBigDecimal("price");
                    int quantity = rs.getInt("quantity");
                    BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
                    total = total.add(itemTotal);
        %>
        <div class="checkout-item">
            <div class="checkout-item-details">
                <h3><%= rs.getString("name") %></h3>
                <p>Quantity: <%= rs.getInt("quantity") %></p>
            </div>
            <div class="checkout-item-price">
                $<%= itemTotal %>
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
        <div class="checkout-total">
            Total: $<%= total %>
        </div>
        <form action="processOrder.jsp" method="post" class="checkout-form">
            <input type="hidden" name="userId" value="<%= userId %>">
            <input type="hidden" name="total" value="<%= total %>">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>
            <label for="phone">Phone:</label>
            <input type="tel" id="phone" name="phone" required>
            <label for="address">Address:</label>
            <textarea id="address" name="address" rows="4" required></textarea>
            <label for="payment_method">Payment Method:</label>
            <select id="payment_method" name="payment_method" required>
                <option value="Credit Card">Credit Card</option>
                <option value="PayPal">PayPal</option>
                <option value="Cash">Cash</option>
            </select>
            <button type="submit">Place Order</button>
        </form>
    </div>
</body>
</html>
