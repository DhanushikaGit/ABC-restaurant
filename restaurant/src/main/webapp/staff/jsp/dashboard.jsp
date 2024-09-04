<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <title>Staff Profile</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #FEA116; /* Primary color */
            --light: #F1F8FF;   /* Light color */
            --dark: #0F172B;    /* Dark color */
        }

        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: var(--light);
        }

        .header {
            background-color: var(--primary);
            color: #fff;
            padding: 10px 50px;
            text-align: center;
            position: fixed;
            width: 100%;
            top: 0;
            left: 0;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .header a {
            color: #fff;
            text-decoration: none;
            margin: 0 15px;
            font-weight: bold;
        }

        .header a:hover {
            text-decoration: underline;
        }

        .content {
            padding: 70px 20px 50px;
        }

        .footer {
            background-color: var(--dark);
            color: #fff;
            text-align: center;
            padding: 15px;
            position: fixed;
            width: 100%;
            bottom: 0;
            left: 0;
            box-shadow: 0 -2px 4px rgba(0, 0, 0, 0.1);
        }

        .footer p {
            margin: 0;
        }

        .dashboard-container {
            background-color: #fff;
            padding: 150px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: 20px auto;
            text-align: center;
        }

        .profile-photo {
            border-radius: 50%;
            width: 120px;
            height: 120px;
            object-fit: cover;
            margin-bottom: 20px;
        }

        .profile-info {
            font-size: 18px;
            color: var(--dark);
        }

        .btn-custom {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
            margin-top: 20px;
        }

        .btn-primary-custom {
            background-color: red;
            color: black;
        }

        .btn-primary-custom:hover {
            opacity: 0.8;
        }

      
    </style>
</head>
<body>

    <%@ include file="staffheader.jsp" %>
<!-- Main Content -->
<div class="dashboard-container">
    <h1>Welcome, <%= session.getAttribute("staffName") %>!</h1>
    
    <% 
        // Retrieve the image path from session
        String imagePath = (String) session.getAttribute("staffImage");
        // Construct the URL for the image
        String imageUrl = (imagePath != null && !imagePath.isEmpty()) 
            ? request.getContextPath() + "/uploads/" + imagePath 
            : request.getContextPath() + "/images/default-profile.png"; 
    %>
    <img src="<%= imageUrl %>" alt="Staff Image" class="profile-photo" onerror="this.onerror=null;this.src='<%= request.getContextPath() %>/images/default-profile.png';">
    
    <div class="profile-info">
        <p><strong>Name:</strong> <%= session.getAttribute("staffName") %></p>
        <p><strong>Position:</strong> <%= session.getAttribute("staffPosition") %></p>
    </div>
    <a href="logout.jsp" class="btn btn-primary-custom">Logout</a>
</div>

<!-- Footer -->
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>

<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>
