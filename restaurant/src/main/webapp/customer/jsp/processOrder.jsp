<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <link href="/restaurant/customer/css/index.css" rel="stylesheet">
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <title>Order Confirmation</title>
    <!-- Add your stylesheet links here -->
    <style>
        /* Your existing CSS */
        :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        body {
            background-color: var(--light);
            color: var(--dark);
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .confirmation-container {
            max-width: 800px;
            margin: 50px auto;
            background-color: #fff;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            padding: 20px;
        }

        h2 {
            color: var(--primary);
            border-bottom: 2px solid var(--primary);
            padding-bottom: 10px;
            margin-bottom: 20px;
        }

        .order-details p,
        .order-items p {
            margin: 5px 0;
        }

        .order-item {
            display: flex;
            align-items: center;
            border-bottom: 1px solid #ddd;
            padding: 10px 0;
        }

        .order-item img {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 8px;
            margin-right: 20px;
        }

        .order-item-details {
            flex-grow: 1;
        }

        .order-item-details h3 {
            margin: 0;
            font-size: 18px;
            color: var(--dark);
        }

        .order-item-price {
            font-size: 18px;
            color: var(--primary);
        }

        .order-total {
            text-align: right;
            font-size: 24px;
            font-weight: bold;
            margin-top: 20px;
            color: var(--primary);
        }

        .success-message {
            padding: 10px;
            background-color: #d4edda;
            border: 1px solid #c3e6cb;
            color: #155724;
            border-radius: 5px;
            margin-bottom: 20px;
            font-size: 18px;
            text-align: center;
        }
    </style>
</head>
<body>

<%@ include file="header.jsp" %>
<div class="container-xxl py-5 bg-dark hero-header mb-5">
    <div class="container text-center my-5 pt-5 pb-4">
        <h1 class="display-3 text-white mb-3 animated slideInDown">Your Delivery Summary</h1>
        <nav aria-label="breadcrumb">
            <ol class="breadcrumb justify-content-center text-uppercase">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Pages</a></li>
                <li class="breadcrumb-item text-white active" aria-current="page">Your Delivery Summary</li>
            </ol>
        </nav>
    </div>
</div>
<div class="text-center wow fadeInUp" data-wow-delay="0.1s">
    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Your Order Details</h5>
    <h1 class="mb-5">Thank You For Your Order</h1>
</div>

<div class="confirmation-container">
    <%
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        BigDecimal total = new BigDecimal(request.getParameter("total"));
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("payment_method");
        String orderType = request.getParameter("order_type"); // New parameter
        int orderId = 0;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

            // Insert order into neworders table
            String insertSql = "INSERT INTO neworders (user_id, name, email, phone, address, payment_method, order_type) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
            pstmt.setInt(1, userId);
            pstmt.setString(2, name);
            pstmt.setString(3, email);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, paymentMethod);
            pstmt.setString(7, orderType); // Set order type
            pstmt.executeUpdate();

            // Retrieve the generated order ID
            rs = pstmt.getGeneratedKeys();
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            // Retrieve order items before clearing the cart
            String itemsSql = "SELECT c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
            pstmt = conn.prepareStatement(itemsSql);
            pstmt.setInt(1, userId);
            rs = pstmt.executeQuery();

    %>
    <div class="success-message">
        Your purchase was successful! Your order ID is <%= orderId %>.
    </div>

    <div class="order-details">
        <h2>Order Details</h2>
        <p><strong>Order ID:</strong> <%= orderId %></p>
        <p><strong>Name:</strong> <%= name %></p>
        <p><strong>Email:</strong> <%= email %></p>
        <p><strong>Phone:</strong> <%= phone %></p>
        <p><strong>Address:</strong> <%= address %></p>
        <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
        <p><strong>Order Type:</strong> <%= orderType %></p> <!-- Display order type -->
    </div>

    <div class="order-items">
        <h2>Order Items</h2>
    <%
            while (rs.next()) {
                BigDecimal price = rs.getBigDecimal("price");
                int quantity = rs.getInt("quantity");
                BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
    %>
    <div class="order-item">
        <img src="<%= request.getContextPath() + "/uploads/" + rs.getString("image") %>" alt="Food Image">
        <div class="order-item-details">
            <h3><%= rs.getString("name") %></h3>
            <p>Quantity: <%= quantity %></p>
        </div>
        <div class="order-item-price">
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
    <div class="order-total">
        Total: $<%= total %>
    </div>
    
    <%
        // Clear the cart after displaying order items
        try {
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            String deleteSql = "DELETE FROM cart WHERE user_id = ? AND status = 'pending'";
            pstmt = conn.prepareStatement(deleteSql);
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
</div>
<%@ include file="footer.jsp" %>
</body>
</html>
