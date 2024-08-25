<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Cancelled</title>
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
        <h2>Order Cancelled</h2>
        <p>Your order has been successfully canceled. We are sorry for any inconvenience.</p>
        <a href="index.jsp" class="button">Return to Home</a>
    </div>
</body>
</html>
