<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Your Cart</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .cart-container {
            max-width: 1200px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .cart-item {
            display: flex;
            align-items: center;
            justify-content: space-between;
            border-bottom: 1px solid #ddd;
            padding: 15px 0;
        }

        .cart-item:last-child {
            border-bottom: none;
        }

        .cart-item img {
            max-width: 100px;
            border-radius: 8px;
        }

        .cart-item-details {
            flex-grow: 1;
            margin-left: 20px;
        }

        .cart-item-details h3 {
            margin: 0;
            font-size: 1.2rem;
            color: #333;
        }

        .cart-item-details p {
            margin: 5px 0;
            color: #777;
        }

        .cart-item-price {
            font-size: 1.1rem;
            color: #333;
        }

        .cart-total {
            text-align: right;
            font-size: 1.5rem;
            margin-top: 20px;
            color: #333;
        }

        .cart-actions {
            text-align: right;
            margin-top: 20px;
        }

        .cart-actions button {
            background-color: #FEA116;
            color: #fff;
            border: none;
            padding: 10px 15px;
            border-radius: 4px;
            cursor: pointer;
        }

        .cart-actions button:hover {
            background-color: #e68900;
        }

    </style>
</head>
<body>
    <div class="cart-container">
        <h1>Your Cart</h1>
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int userId = 1; // Replace with session-based user ID
            BigDecimal total = BigDecimal.ZERO;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
        %>
        <form action="<%= request.getContextPath() %>/customer/jsp/checkout.jsp" method="post">
        <%
                while (rs.next()) {
                    BigDecimal price = rs.getBigDecimal("price");
                    int quantity = rs.getInt("quantity");
                    BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
                    total = total.add(itemTotal);
        %>
        <div class="cart-item">
            <img src="<%= request.getContextPath() + "/uploads/" + rs.getString("image") %>" alt="Food Image">
            <div class="cart-item-details">
                <h3><%= rs.getString("name") %></h3>
                <p>Quantity: <%= rs.getInt("quantity") %></p>
            </div>
            <div class="cart-item-price">
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
        <div class="cart-total">
            Total: $<%= total %>
        </div>
        <input type="hidden" name="total" value="<%= total %>">
        <div class="cart-actions">
            <button type="submit"><i class="las la-credit-card"></i> Proceed to Checkout</button>
            <p><a href="<%= request.getContextPath() %>/customer/jsp/customerViewFoodItems.jsp">Keep Shopping</a></p>
        </div>
        </form>
    </div>
</body>
</html>
