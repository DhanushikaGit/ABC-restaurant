<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
        }

        .dashboard-container {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            margin: auto;
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
            color: #333;
        }

        .btn {
            padding: 10px 15px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 4px;
            margin-top: 20px;
        }

        .btn-primary {
            background-color: #FEA116;
            color: #fff;
        }

        .btn-primary:hover {
            opacity: 0.8;
        }
    </style>
</head>
<body>

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
    <a href="logout.jsp" class="btn btn-primary">Logout</a>
</div>

</body>
</html>
