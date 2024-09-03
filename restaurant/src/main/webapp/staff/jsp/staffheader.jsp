<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Staff Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
    <Style>
    :root {
    --primary: #FEA116; /* Primary color */
    --light: #F1F8FF;   /* Light color */
    --dark: #0F172B;    /* Dark color */
}

/* Basic reset and body styles */
body {
    font-family: Arial, sans-serif;
    background-color: var(--light);
    color: var(--dark);
    margin: 0;
    padding: 0;
}

/* Header styles */
header {
    background-color: var(--primary);
    color: white;
    padding: 10px 0;
    text-align: center;
}

header h1 {
    margin: 0;
}

nav ul {
    list-style: none;
    padding: 0;
}

nav ul li {
    display: inline;
    margin: 0 10px;
}

nav ul li a {
    color: white;
    text-decoration: none;
}

nav ul li a:hover {
    text-decoration: underline;
}

/* Main section styles */
main {
    padding: 20px;
}

section h2 {
    color: var(--dark);
}

/* Table styles */
table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 20px;
}

table th, table td {
    border: 1px solid var(--dark);
    padding: 10px;
    text-align: left;
}

table th {
    background-color: var(--primary);
    color: white;
}

table tr:nth-child(even) {
    background-color: #f9f9f9;
}

/* Footer styles */
footer {
    background-color: var(--dark);
    color: white;
    text-align: center;
    padding: 10px 0;
    position: fixed;
    bottom: 0;
    width: 100%;
}

footer p {
    margin: 0;
}
    
    </style>
</head>
<body>
    <header>
        <h1>ABC Restaurant Staff Dashboard</h1>
        <nav>
            <ul>
                <li><a href="viewreservation.jsp">View Reservations</a></li>
                <li><a href="manageorders.jsp">Manage Orders</a></li>
                <li><a href="managestaff.jsp">Manage Staff</a></li>
                <li><a href="managegallery.jsp">Manage Gallery</a></li>
                <li><a href="logout.jsp">Logout</a></li>
            </ul>
        </nav>
    </header>

    <main>
        <section>
            <h2>Welcome to the Staff Dashboard</h2>
            <p>Use the navigation links to manage reservations, orders, staff, and gallery items. You can also log out from here.</p>
        </section>
    </main>

    <footer>
        <p>&copy; 2024 ABC Restaurant. All rights reserved.</p>
    </footer>
</body>
</html>
