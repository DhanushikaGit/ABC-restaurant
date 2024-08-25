<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Error</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .error { border: 1px solid #f5c6cb; padding: 20px; border-radius: 5px; background-color: #f8d7da; color: #721c24; }
        .error h2 { color: #721c24; }
        .error p { margin: 5px 0; }
        .button { display: inline-block; padding: 10px 20px; margin-top: 20px; font-size: 16px; color: #fff; background-color: #007bff; border: none; border-radius: 5px; text-decoration: none; text-align: center; }
        .button:hover { background-color: #0056b3; }
    </style>
</head>
<body>
    <div class="error">
        <h2>Order Error</h2>
        <p>We encountered an error while processing your order. Please try again later.</p>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null && !errorMessage.isEmpty()) {
        %>
        <p><strong>Error Details:</strong> <%= errorMessage %></p>
        <%
            }
        %>
        <p>If the problem persists, please contact our support team.</p>
        <a href="index.jsp" class="button">Return to Home</a> <!-- Adjust the link if your home page URL is different -->
    </div>
</body>
</html>
