<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
</head>
<style>
 body {
            font-family: Arial, sans-serif;
            background-color:  #0F172B;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }

        /* Header Styling */
        header {
            width: 100%;
            padding: 20px 50px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color:  #0F172B;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .sidebar-heading {
            font-size: 24px;
            font-weight: bold;
            color: #e99656;
            display: flex;
            align-items: center;
        }

        .sidebar-heading i {
            margin-right: 10px;
        }

        nav a {
            margin: 0 15px;
            text-decoration: none;
              color: white;
            font-weight: 600;
            font-size: 16px;
            transition: color 0.3s ease;
        }

        nav a:hover {
            color: #d4854c;
        }

        nav .signup {
            background-color:  #d4854c;
            color: white;
            padding: 10px 25px;
            border-radius: 25px;
            transition: background-color 0.3s ease;
        }

        nav .signup:hover {
            background-color: white;
            color: #333;
        }

        /* Content Area */
        .content {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 80px 20px;
            width: 100%;
            max-width: 1200px;
            margin-top: 20px;
        }

       
</style>
<body>
<div class="container">
        <header>
            <div class="sidebar-heading text-center py-4 primary-text fs-4 fw-bold text-uppercase border-bottom">
                <i class="fa fa-utensils me-3"></i>ABC Restaurant
            </div>
            <nav>
                <a href="#">What we offer</a>
                <a href="/restaurant/customer/jsp/login.jsp">Login</a>
                <a href="/restaurant/customer/jsp/register.jsp" class="signup">Sign Up</a>
            </nav>
        </header>
        </div>
</body>
</html>