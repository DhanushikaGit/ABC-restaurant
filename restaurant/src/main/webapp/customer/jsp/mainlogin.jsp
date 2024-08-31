<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Craving Something?</title>
    <link rel="stylesheet" href="styles.css">
    <style>
  /* General Styling */
body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    margin: 0;
    padding: 0;
    background-color: #f8f3ec;
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
    background-color: #f8f3ec;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
}

header .logo {
    font-size: 24px;
    font-weight: bold;
    color: #e99656;
}

nav a {
    margin: 0 15px;
    text-decoration: none;
    color: #333;
    font-weight: 600;
    font-size: 16px;
    transition: color 0.3s ease;
}

nav a:hover {
    color:  #d4854c;
}

nav .signup {
    background-color: #333;
    color: white;
    padding: 10px 25px;
    border-radius: 25px;
    transition: background-color 0.3s ease;
}

nav .signup:hover {
    background-color: white;
}

/* Content Area */
.content {
    display: flex;
    justify-content: center;
    align-items: center;
    padding: 80px 0;
    width: 80%;
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
    color: #666;
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

  
    </style>
</head>
<body>
    <div class="container">
        <header>
            <div class="logo">🔺</div>
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
</html>
