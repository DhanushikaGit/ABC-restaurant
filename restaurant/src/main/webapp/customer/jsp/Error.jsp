<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        /* Add your styles here */
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            text-align: center;
            padding-top: 50px;
        }

        .error-container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
            background-color: #fff;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }

        .error-container h1 {
            color: #333;
            font-size: 2rem;
        }

        .error-container p {
            color: #777;
            font-size: 1.2rem;
        }

        .error-container a {
            color: #FEA116;
            text-decoration: none;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <h1>Oops!</h1>
        <p>Something went wrong with your order. Please try again later.</p>
        <p><a href="<%= request.getContextPath() %>/customer/jsp/customerViewFoodItems.jsp">Back to Menu</a></p>
    </div>
</body>
</html>
