<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Restaurant</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" />
    <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
        /* General Styling */
         :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
        background-color:  #0F172B;
            color: #333;
        }

        .container {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
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

       
/* Food Images Styling */
.food-images {
    position: relative;
    width: 350px;
    height: 350px;
    margin-right: 70px; /* Adds spacing between the images and text */
}

.food-images img {
    border-radius: 50%;
    position: absolute;
    width: 250px; /* Larger image size */
    height: 250px; /* Larger image size */

   
}

.food-images .top {
    top: 0%;
    left: 50%;
    transform: translateX(-50%);
}

.food-images .left {
    bottom: -50%;
    left: 80%;
    transform: translateY(-10%);
}

.food-images .right {
    bottom: -50%;
    right: 90%;
    transform: translateY(-10%);
}

/* Text Content Styling */
.text-content {
    max-width: 1000px;  /* Increased width for more space */
    text-align: left;
    margin-left: 300px;  /* Added margin to move it closer to the left */
     margin-top: 250px;
}

.text-content h1 {
    font-size: 52px; /* Increased font size */
    color: #e99656;
    margin-bottom: 25px;
}

.text-content p {
    font-size: 22px; /* Increased font size */
    color: white;
    margin-bottom: 20px;
}

/* Search Bar Styling */
.search-bar {
    margin-top: 35px;
    display: flex;
    align-items: center;
}

.search-bar select {
    padding: 15px;  /* Increased padding */
    font-size: 18px;  /* Increased font size */
    border-radius: 25px 0 0 25px;
    border: 1px solid #ccc;
    flex: 1;
    outline: none;
    transition: border-color 0.3s ease;
}

.search-bar select:focus {
    border-color: #e99656;
}

.search-bar button {
    padding: 15px 40px;  /* Increased padding */
    font-size: 18px;  /* Increased font size */
    border-radius: 0 25px 25px 0;
    border: none;
    background-color: #e99656;
    color: black;
    font-weight: bold;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

.search-bar button:hover {
    background-color: white;
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
       
    </style>
</head>
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
        <div class="content">
            <div class="food-images">
                <img src="/restaurant/customer/images/menu-1.jpg" alt="Dumplings" class="top">
                <img src="/restaurant/customer/images/menu-2.jpg" alt="Crepes" class="left">
                <img src="/restaurant/customer/images/menu-3.jpg" alt="Smoothie" class="right">
            </div>
            <div class="text-content">
                <h1>Craving Something?</h1>
                <p>Let's get you started!</p>
                <div class="search-bar">
                   <form action="/restaurant/customer/jsp/register.jsp" method="get">
    <select name="location">
        <option value="anuradhapura">Anuradhapura</option>
        <option value="colombo">Colombo</option>
        <option value="galle">Galle</option>
        <option value="kandy">Kandy</option>
        <option value="jaffna">Jaffna</option>
    </select>
    <button type="submit">Search</button>
</form>
                   
                </div>
            </div>
        </div>
    </div>
</body>

<body>
    <footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</html>



