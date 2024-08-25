<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Confirmation</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .confirmation { border: 1px solid #ddd; padding: 20px; border-radius: 5px; background-color: #d4edda; color: #155724; }
        .confirmation h2 { color: #155724; }
        .confirmation p { margin: 5px 0; }
        .button { display: inline-block; padding: 10px 20px; margin-top: 20px; font-size: 16px; color: #fff; background-color: #007bff; border: none; border-radius: 5px; text-decoration: none; text-align: center; }
        .button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="confirmation">
        <h2>Order Confirmation</h2>
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
        
        <a href="index.jsp" class="button">Return to Home</a>
        <a href="/restaurant/customer/jsp/customerEditOrder.jsp?orderId=<%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "0" %>" class="button">Edit Order</a>
        <a href="CancelOrderServlet?orderId=<%= request.getAttribute("orderId") != null ? request.getAttribute("orderId") : "0" %>" class="button">Cancel Order</a>
    </div>
</body>
</html>
