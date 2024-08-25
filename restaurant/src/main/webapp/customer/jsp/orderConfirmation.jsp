<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ABC Restaurant Order Confirmation</title>
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
    
    :root {
    --primary: #FEA116;
    --light: #F1F8FF;
    --dark: #0F172B;
}

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

.confirmation {
    border: 1px solid var(--dark);
    padding: 30px;
    border-radius: 8px;
    background-color: var(--light);
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    max-width: 600px;
    width: 100%;
    font-family: Arial, sans-serif;
    color: var(--dark);
    margin: 50px auto;
}

.confirmation h2 {
    color: var(--primary);
    font-size: 24px;
    margin-bottom: 20px;
    text-align: center;
}

.confirmation p {
    margin: 10px 0;
    font-size: 16px;
}

.button {
    display: inline-block;
    padding: 12px 20px;
    margin-top: 20px;
    font-size: 16px;
    color: #fff;
    background-color: var(--primary);
    border: none;
    border-radius: 5px;
    text-decoration: none;
    text-align: center;
    transition: background-color 0.3s ease;
    cursor: pointer;
}

.button:hover {
    background-color: var(--dark);
}

.button-container {
    display: flex;
    justify-content: space-between;
    margin-top: 30px;
}
    
    </style>
     <link href="/restaurant/customer/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/css/tempusdominus-bootstrap-4.min.css" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/tempusdominus-bootstrap-4/5.1.5/js/tempusdominus-bootstrap-4.min.js"></script>
</head>
<body>

<%@ include file="header.jsp" %>
  <div class="container-xxl py-5 bg-dark hero-header mb-5">
        <div class="container text-center my-5 pt-5 pb-4">
             <h1 class="display-3 text-white mb-3 animated slideInDown">Your Order Details</h1>
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb justify-content-center text-uppercase">
                    <li class="breadcrumb-item"><a href="#">Home</a></li>
                    <li class="breadcrumb-item"><a href="#">Pages</a></li>
                    <li class="breadcrumb-item text-white active" aria-current="page">Order Details</li>
                </ol>
            </nav>
        </div>
    </div>
    <div class="confirmation">
        <div class="text-center wow fadeInUp" data-wow-delay="0.1s">
                    <h5 class="section-title ff-secondary text-center text-primary fw-normal">Thank You For Your Order</h5>
                    <h1 class="mb-5"> Your Order Confirmation</h1>
                </div>
        <p>Thank you for your order, <%= request.getAttribute("customerName") != null ? request.getAttribute("customerName") : "Customer" %>!</p>
        <p>We have received your order and are currently processing it. You will be contacted shortly regarding the status of your order.</p>
        <p><strong>Food Item:</strong> <%= request.getAttribute("foodName") != null ? request.getAttribute("foodName") : "N/A" %></p>
        <p><strong>Price:</strong> $<%= request.getAttribute("foodPrice") != null ? request.getAttribute("foodPrice") : "0.00" %></p>
        <p><strong>Order Type:</strong> <%= request.getAttribute("orderType") != null ? request.getAttribute("orderType") : "N/A" %></p>

        <%
            String orderType = (String) request.getAttribute("orderType");
            if ("dineIn".equals(orderType)) {
                String dineInTime = (String) request.getAttribute("dineInTime");
                if (dineInTime != null && !dineInTime.isEmpty()) {
        %>
        <p><strong>Preferred Dining Time:</strong> <%= dineInTime %></p>
        <%
                }
            } else if ("online".equals(orderType)) {
                String deliveryAddress = (String) request.getAttribute("deliveryAddress");
                if (deliveryAddress != null && !deliveryAddress.isEmpty()) {
        %>
        <p><strong>Delivery Address:</strong> <%= deliveryAddress %></p>
        <%
                }
            }
        %>

        <p><strong>Meal Size:</strong> <%= request.getAttribute("mealSize") != null ? request.getAttribute("mealSize") : "N/A" %></p>
        <p><strong>Meal Type:</strong> <%= request.getAttribute("mealType") != null ? request.getAttribute("mealType") : "N/A" %></p>
        <p><strong>Meal Quantity:</strong> <%= request.getAttribute("mealQuantity") != null ? request.getAttribute("mealQuantity") : "1" %></p>
        <p><strong>Total Price:</strong> $<%= request.getAttribute("totalPrice") != null ? request.getAttribute("totalPrice") : "0.00" %></p>

        <p><strong>Customer Name:</strong> <%= request.getAttribute("customerName") != null ? request.getAttribute("customerName") : "N/A" %></p>
        <p><strong>Customer Email:</strong> <%= request.getAttribute("customerEmail") != null ? request.getAttribute("customerEmail") : "N/A" %></p>
        <p><strong>Customer Contact:</strong> <%= request.getAttribute("customerContact") != null ? request.getAttribute("customerContact") : "N/A" %></p>

        <p>Your order is being processed. We will notify you when it's ready.</p>

        <div class="button-container">
            <a href="index.jsp" class="button">Return to Home</a>
            <a href="/restaurant/customer/jsp/customerEditOrder.jsp?orderId=<%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "0" %>" class="button">Edit Order</a>
            <a href="CancelOrderServlet?orderId=<%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "0" %>" class="button">Cancel Order</a>
        </div>
    </div>
     <%@ include file="footer.jsp" %>
</body>
</html>
