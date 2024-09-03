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

        .edit-button, .cancel-button {
            background-color: var(--primary);
            color: black;
            border: none;
            padding: 5px 10px;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
                border: 1px solid var(--primary);
        }

        .edit-button:hover, .cancel-button:hover {
            background-color: white;
              border: 1px solid var(--primary);
        }

        .cart-total {
            font-size: 1.2rem;
            margin-top: 20px;
            text-align: right;
            font-weight: bold;
        }

        /*** Navbar ***/
        .navbar-dark .navbar-nav .nav-link {
            margin-left: 25px;
            padding: 35px 0;
            font-size: 15px;
            color: var(--light) !important;
            text-transform: uppercase;
            font-weight: 500;
            outline: none;
            transition: .5s;
        }

        .sticky-top.navbar-dark .navbar-nav .nav-link {
            padding: 20px 0;
        }

        .navbar-dark .navbar-nav .nav-link:hover,
        .navbar-dark .navbar-nav .nav-link.active {
            color: var(--primary) !important;
        }

        .navbar-dark .navbar-brand img {
            max-height: 60px;
            transition: .5s;
        }

        .sticky-top.navbar-dark .navbar-brand img {
            max-height: 45px;
        }

        @media (max-width: 991.98px) {
            .sticky-top.navbar-dark {
                position: relative;
            }

            .navbar-dark .navbar-collapse {
                margin-top: 15px;
                border-top: 1px solid rgba(255, 255, 255, .1);
            }

            .navbar-dark .navbar-nav .nav-link,
            .sticky-top.navbar-dark .navbar-nav .nav-link {
                padding: 10px 0;
                margin-left: 0;
            }

            .navbar-dark .navbar-brand img {
                max-height: 45px;
            }
        }

        @media (min-width: 992px) {
            .navbar-dark {
                position: absolute;
                width: 100%;
                top: 0;
                left: 0;
                z-index: 999;
                background: transparent !important;
            }

            .sticky-top.navbar-dark {
                position: fixed;
                background: var(--dark) !important;
            }
        }
    </style>
</head>
<body>
    <%@ include file="header.jsp" %>
    <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
            <h1 class="display-3 text-white mb-3 animated slideInDown">Your Shopping Cart</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Shopping Cart</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
        <h5 class="section-title ff-secondary text-center text-primary fw-normal">Our Menu</h5>
        <h1 class="mb-5">Your Shopping Cart</h1>
    </div>
    
      <div class="cart-container">
        <%
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            int userId = 1; // Replace with session-based user ID
            BigDecimal total = BigDecimal.ZERO;

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");

                String sql = "SELECT c.cart_id, c.quantity, f.name, f.price, f.image FROM cart c JOIN food_items f ON c.food_id = f.id WHERE c.user_id = ? AND c.status = 'pending'";
                pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, userId);
                rs = pstmt.executeQuery();
        %>
        <% while (rs.next()) { 
            BigDecimal price = rs.getBigDecimal("price");
            int quantity = rs.getInt("quantity");
            BigDecimal itemTotal = price.multiply(BigDecimal.valueOf(quantity));
            total = total.add(itemTotal);
            int cartId = rs.getInt("cart_id");
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
            <div class="cart-item-actions">
                <form action="<%= request.getContextPath() %>/customer/jsp/cancelCartItem.jsp" method="post">
                    <input type="hidden" name="cart_id" value="<%= cartId %>">
                    <button type="submit" class="cancel-button">Cancel</button>
                </form>
            </div>
        </div>
        <% } %>
        <div class="cart-total">
            Total: $<%= total %>
        </div>
        <form action="<%= request.getContextPath() %>/customer/jsp/checkout.jsp" method="post">
            <div class="cart-actions">
                <input type="hidden" name="total" value="<%= total %>">
                <button type="submit"><i class="las la-credit-card"></i> Proceed to Checkout</button>
                <p><a href="<%= request.getContextPath() %>/customer/jsp/customerViewFoodItems.jsp">Keep Shopping</a></p>
            </div>
        </form>
        <% 
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
            } finally {
                if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
    </div>
     <%@ include file="footer.jsp" %>
</body>
</html>
