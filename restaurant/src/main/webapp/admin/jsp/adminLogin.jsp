<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>ABC Restaurant Admin Login</title>
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
        :root {
            --primary: #FEA116; /* Primary color (bright yellow-orange) */
            --light: #F1F8FF;   /* Light color (very light blue) */
            --dark: #0F172B;    /* Dark color (very dark blue) */
        }

        /* Style for the form container */
        .login-container {
            max-width: 500px; /* Increase the form width */
            margin: 50px auto; /* Center the form horizontally and add vertical margin */
            padding: 20px; /* Add padding inside the form */
            background-color: var(--light); /* Light background color for the form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Light shadow for depth */
        }

        /* Style for the form inputs */
        form input[type="text"],
        form input[type="password"],
        form input[type="submit"] {
            width: 100%; /* Full width of the form container */
            padding: 12px; /* Increased padding for inputs */
            margin-bottom: 16px; /* Space below each input */
            border: 1px solid #ddd; /* Light border */
            border-radius: 4px; /* Rounded corners */
            box-sizing: border-box; /* Include padding and border in the element's total width and height */
            font-size: 16px; /* Font size for better readability */
        }

        /* Style for the submit button */
        form input[type="submit"] {
            background-color: Black; /* Black background color */
            color: #fff; /* White text color */
            border: none; /* Remove default border */
            padding: 12px 20px; /* Padding inside the button */
            font-size: 16px; /* Font size */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            transition: background-color 0.3s ease; /* Smooth transition for background color */
        }

        form input[type="submit"]:hover {
            background-color: #e68900; /* Slightly lighter color on hover */
        }

        /* Style for the placeholder text */
        form input::placeholder {
            color: #888; /* Light gray color for placeholder text */
        }

        /* Style for the forgot password link */
        .forgot-password {
            display: block; /* Make the link a block element */
            margin-top: 10px; /* Space above the link */
            text-align: center; /* Center the text */
            color: var(--primary); /* Primary color for the link */
            text-decoration: none; /* Remove underline from the link */
            font-size: 14px; /* Font size for the link */
        }

        .forgot-password:hover {
            text-decoration: underline; /* Underline on hover */
            color: #e68900; /* Change color on hover */
        }

        /* Style for the error message */
        .error-message {
            color: red; /* Red color for error messages */
            font-size: 16px; /* Font size for better readability */
            margin-bottom: 16px; /* Space below the error message */
            text-align: center; /* Center the text */
            padding: 10px; /* Add padding around the text */
            border: 1px solid red; /* Red border for emphasis */
            border-radius: 4px; /* Rounded corners for the border */
            background-color: #fdd; /* Light red background */
        }

        /* Style for the h1 title */
        h1 {
            font-family: 'Roboto', sans-serif; /* Use a modern font */
            font-size: 2.5rem; /* Large font size for emphasis */
            color: black; /* Primary color for the text */
            text-align: center; /* Center the title */
            margin: 30px 0; /* Add vertical margin */
            padding: 10px; /* Add padding around the text */
            background: linear-gradient(45deg, var(--primary), #ffca28); /* Gradient background */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); /* Shadow for depth */
            position: relative; /* For pseudo-element positioning */
            overflow: hidden; /* Ensure background gradient stays within bounds */
        }

        /* Add decorative lines above and below the title */
        h1::before, h1::after {
            content: ''; /* Empty content for pseudo-elements */
            position: absolute; /* Absolute positioning */
            left: 0; /* Align to left edge */
            width: 100%; /* Full width */
            height: 4px; /* Line height */
            background: var(--dark); /* Line color */
        }

        h1::before {
            top: -10px; /* Position above the title */
            transform: scaleX(0.8); /* Slightly smaller than the full width */
            transform-origin: left; /* Scale from the left edge */
        }

        h1::after {
            bottom: -10px; /* Position below the title */
            transform: scaleX(0.8); /* Slightly smaller than the full width */
            transform-origin: right; /* Scale from the right edge */
        }

        /* Responsive styling for smaller screens */
        @media (max-width: 600px) {
            h1 {
                font-size: 2rem; /* Adjust font size on smaller screens */
            }

            .login-container {
                padding: 15px; /* Adjust padding for smaller screens */
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Admin Login</h1>
        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="error-message"><%= errorMessage %></div>
        <% 
            } 
        %>
        <form action="http://localhost:8090/restaurant/AdminLogin" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
            <a href="http://localhost:8090/restaurant/forgotPassword" class="forgot-password">Forgot Password?</a>
        </form>
    </div>
</body>
  <%@ include file="adminfooter.jsp" %>
</html>
