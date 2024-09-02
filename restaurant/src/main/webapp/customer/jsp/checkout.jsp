<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
<link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="/restaurant/customer/css/index.css" rel="stylesheet">
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <meta charset="UTF-8">
    <meta charset="UTF-8">
    <title>Order Placement Form</title>
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

        .checkout-form .address-field {
            display: none;
        }
    </style>
    <script>
        function toggleAddressField() {
            var deliveryField = document.getElementById("address-field");
            var takeoutField = document.getElementById("takeout-field");
            if (document.getElementById("delivery").checked) {
                deliveryField.style.display = "block";
            } else {
                deliveryField.style.display = "none";
            }
        }
    </script>
</head>
<body>

<%@ include file="header.jsp" %>
    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Add Your Delivery Information</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Order Placement Form</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Add Your Delivery Information</h5>
        <h1 class="mb-5">Thank You For Your Order</h1>
    </div>
    <div class="checkout-container">
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
            <label>Order Type:</label>
            <input type="radio" id="takeout" name="order_type" value="Takeout" checked onclick="toggleAddressField()">
            <label for="takeout">Takeout</label>
            <input type="radio" id="delivery" name="order_type" value="Delivery" onclick="toggleAddressField()">
            <label for="delivery">Delivery</label>
            <div id="address-field" class="address-field">
                <label for="address">Address:</label>
                <textarea id="address" name="address" rows="4"></textarea>
            </div>
            <label for="payment_method">Payment Method:</label>
            <select id="payment_method" name="payment_method" required>
                <option value="Credit Card">Credit Card</option>
                <option value="PayPal">PayPal</option>
                <option value="Cash">Cash</option>
            </select>
            <button type="submit">Place Order</button>
        </form>
    </div>
      <%@ include file="footer.jsp" %>
</body>
</html>
