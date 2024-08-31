<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <link rel="stylesheet" href="https://maxst.icons8.com/vue-static/landings/line-awesome/line-awesome/1.3.0/css/line-awesome.min.css">
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        .confirmation-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .confirmation-container h1 {
            font-size: 1.5rem;
            color: #333;
        }

        .order-details, .order-items {
            margin-top: 20px;
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

        .order-total {
            text-align: right;
            font-size: 1.5rem;
            margin-top: 20px;
            color: #333;
        }
    </style>
</head>
<body>
    <div class="confirmation-container">
        <h1>Thank You for Your Order!</h1>
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
            int orderId = 0;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                // Insert order into neworders table
                String insertSql = "INSERT INTO neworders (user_id, name, email, phone, address, payment_method) VALUES (?, ?, ?, ?, ?, ?)";
                pstmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS);
                pstmt.setInt(1, userId);
                pstmt.setString(2, name);
                pstmt.setString(3, email);
                pstmt.setString(4, phone);
                pstmt.setString(5, address);
                pstmt.setString(6, paymentMethod);
                pstmt.executeUpdate();

                // Retrieve the generated order ID
                rs = pstmt.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }

                // Optionally, clear the cart
                String deleteSql = "DELETE FROM cart WHERE user_id = ? AND status = 'pending'";
                pstmt = conn.prepareStatement(deleteSql);
                pstmt.setInt(1, userId);
                pstmt.executeUpdate();

                // Retrieve order items
                String itemsSql = "SELECT c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
                pstmt = conn.prepareStatement(itemsSql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
        %>
        <div class="order-details">
            <h2>Order Details</h2>
            <p><strong>Order ID:</strong> <%= orderId %></p>
            <p><strong>Name:</strong> <%= name %></p>
            <p><strong>Email:</strong> <%= email %></p>
            <p><strong>Phone:</strong> <%= phone %></p>
            <p><strong>Address:</strong> <%= address %></p>
            <p><strong>Payment Method:</strong> <%= paymentMethod %></p>
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
                <p>Quantity: <%= rs.getInt("quantity") %></p>
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
    </div>
</body>
</html>
