<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Food</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .hidden { display: none; }
    </style>
</head>
<body>
    <h2>Order Food</h2>
    <%
        int id = Integer.parseInt(request.getParameter("id"));
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String name = "";
        String description = "";
        String price = "";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
            String sql = "SELECT name, description, price FROM food_items WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                name = rs.getString("name");
                description = rs.getString("description");
                price = rs.getString("price");
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    %>
    <form action="http://localhost:8090/restaurant/OrderFoodServlet" method="post">
        <input type="hidden" name="foodId" value="<%= id %>">
        <input type="hidden" name="foodName" value="<%= name %>">
        <input type="hidden" name="foodPrice" value="<%= price %>">
        
        <label>Order Type:</label><br>
        <input type="radio" id="dineIn" name="orderType" value="dineIn" checked>
        <label for="dineIn">Dine In</label><br>
        <input type="radio" id="takeout" name="orderType" value="takeout">
        <label for="takeout">Take Out</label><br>
        <input type="radio" id="online" name="orderType" value="online">
        <label for="online">Online</label><br><br>

        <div id="dineInDetails" class="hidden">
            <label for="dineInTime">Preferred Dining Time:</label>
            <input type="datetime-local" id="dineInTime" name="dineInTime"><br><br>
        </div>

        <div id="onlineDetails" class="hidden">
            <label for="deliveryAddress">Delivery Address:</label><br>
            <textarea id="deliveryAddress" name="deliveryAddress" rows="4" cols="50"></textarea><br><br>
        </div>

        <div>
            <label for="mealSize">Meal Size:</label>
            <select id="mealSize" name="mealSize">
                <option value="small">Small</option>
                <option value="medium">Medium</option>
                <option value="large">Large</option>
            </select><br><br>
            
            <label for="mealType">Meal Type:</label>
            <select id="mealType" name="mealType">
                <option value="breakfast">Breakfast</option>
                <option value="lunch">Lunch</option>
                <option value="dinner">Dinner</option>
            </select><br><br>
        </div>
        <div>
    <label for="mealQuantity">Meal Quantity:</label>
    <input type="number" id="mealQuantity" name="mealQuantity" value="1" min="1" required><br><br>
</div>
        

        <div id="customerDetails">
            <label for="customerName">Name:</label>
            <input type="text" id="customerName" name="customerName" required><br><br>
            
            <label for="customerEmail">Email:</label>
            <input type="email" id="customerEmail" name="customerEmail" required><br><br>
            
            <label for="customerContact">Contact Number:</label>
            <input type="text" id="customerContact" name="customerContact" required><br><br>
        </div>

        <input type="submit" value="Place Order" action="http://localhost:8090/restaurant/customer/jsp/orderConfirmation.jsp">
    </form>

    <script>
        // JavaScript to toggle visibility of dining time and online address inputs
        document.addEventListener('DOMContentLoaded', function() {
            var dineInDetails = document.getElementById('dineInDetails');
            var onlineDetails = document.getElementById('onlineDetails');
            
            document.querySelectorAll('input[name="orderType"]').forEach(function(elem) {
                elem.addEventListener('change', function() {
                    if (this.value === 'dineIn') {
                        dineInDetails.classList.remove('hidden');
                        onlineDetails.classList.add('hidden');
                    } else if (this.value === 'online') {
                        dineInDetails.classList.add('hidden');
                        onlineDetails.classList.remove('hidden');
                    } else {
                        dineInDetails.classList.add('hidden');
                        onlineDetails.classList.add('hidden');
                    }
                });
            });

            // Set initial visibility
            if (document.querySelector('input[name="orderType"]:checked').value === 'dineIn') {
                dineInDetails.classList.remove('hidden');
                onlineDetails.classList.add('hidden');
            } else if (document.querySelector('input[name="orderType"]:checked').value === 'online') {
                dineInDetails.classList.add('hidden');
                onlineDetails.classList.remove('hidden');
            } else {
                dineInDetails.classList.add('hidden');
                onlineDetails.classList.add('hidden');
            }
        });
    </script>
</body>
</html>
