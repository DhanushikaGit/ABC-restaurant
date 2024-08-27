<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Order</title>
</head>
<body>

<h2>Edit Order</h2>

<form action="http://localhost:8090/restaurant/UpdateOrderServlet2" method="post">
    <input type="hidden" name="order_id" value="<%= request.getAttribute("order_id") %>">
    
    <label for="food_name">Food Name:</label>
    <input type="text" id="food_name" name="food_name" value="<%= request.getAttribute("food_name") %>" required>
    <br>
    
    <label for="food_price">Food Price:</label>
    <input type="text" id="food_price" name="food_price" value="<%= request.getAttribute("food_price") %>" required>
    <br>
    
    <label for="order_type">Order Type:</label>
    <input type="text" id="order_type" name="order_type" value="<%= request.getAttribute("order_type") %>" required>
    <br>
    
    <label for="dine_in_time">Dine-In Time:</label>
    <input type="datetime-local" id="dine_in_time" name="dine_in_time" value="<%= request.getAttribute("dine_in_time") != null ? new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(request.getAttribute("dine_in_time")) : "" %>" required>
    <br>
    
    <label for="delivery_address">Delivery Address:</label>
    <input type="text" id="delivery_address" name="delivery_address" value="<%= request.getAttribute("delivery_address") %>" required>
    <br>
    
    <label for="meal_size">Meal Size:</label>
    <input type="text" id="meal_size" name="meal_size" value="<%= request.getAttribute("meal_size") %>" required>
    <br>
    
    <label for="meal_type">Meal Type:</label>
    <input type="text" id="meal_type" name="meal_type" value="<%= request.getAttribute("meal_type") %>" required>
    <br>
    
    <label for="customer_name">Customer Name:</label>
    <input type="text" id="customer_name" name="customer_name" value="<%= request.getAttribute("customer_name") %>" required>
    <br>
    
    <label for="customer_email">Customer Email:</label>
    <input type="email" id="customer_email" name="customer_email" value="<%= request.getAttribute("customer_email") %>" required>
    <br>
    
    <label for="customer_contact">Customer Contact:</label>
    <input type="text" id="customer_contact" name="customer_contact" value="<%= request.getAttribute("customer_contact") %>" required>
    <br>
    
    <label for="order_date">Order Date:</label>
    <input type="datetime-local" id="order_date" name="order_date" value="<%= request.getAttribute("order_date") != null ? new java.text.SimpleDateFormat("yyyy-MM-dd'T'HH:mm").format(request.getAttribute("order_date")) : "" %>" required>
    <br>
    
    <label for="meal_quantity">Quantity:</label>
    <input type="number" id="meal_quantity" name="meal_quantity" value="<%= request.getAttribute("meal_quantity") %>" required>
    <br>
    
    <label for="total_price">Total Price:</label>
    <input type="text" id="total_price" name="total_price" value="<%= request.getAttribute("total_price") %>" required>
    <br>
    
    <button type="submit">Update</button>
    <a href="/restaurant/staff/jsp/vieworder.jsp">Cancel</a>
</form>


</body>
</html>
