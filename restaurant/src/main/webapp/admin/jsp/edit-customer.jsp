<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer</title>
    
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
    /* General body styles */
body {
    font-family: Arial, sans-serif; /* Basic font family */
    margin: 0; /* Remove default margin */
    padding: 0; /* Remove default padding */
    background-color: #f9f9f9; /* Light background color */
}

/* Main content container */
.main-content {
    margin: 20px auto; /* Centered container with top and bottom margins */
    max-width: 800px; /* Maximum width of the container */
    padding: 20px; /* Padding inside the container */
    background-color: #ffffff; /* White background for the container */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
}


/* Form styling */
form {
    display: flex;
    flex-direction: column; /* Stack form elements vertically */
    gap: 16px; /* Space between form elements */
}

form label {
    font-weight: bold; /* Bold text for labels */
    color: #333; /* Dark text color */
}

form input[type="text"],
form input[type="email"],
form input[type="password"] {
    width: 100%; /* Full width */
    padding: 10px; /* Padding inside the input */
    border: 1px solid #ddd; /* Light border */
    border-radius: 4px; /* Rounded corners */
    box-sizing: border-box; /* Include padding and border in the width */
    font-size: 16px; /* Font size for readability */
}

form button {
    background-color: #333; /* Dark background color for button */
    color: #fff; /* White text color */
    border: none; /* Remove default border */
    padding: 10px 20px; /* Padding inside the button */
    font-size: 16px; /* Font size */
    border-radius: 4px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor */
    transition: background-color 0.3s ease; /* Smooth transition for background color */
}

form button:hover {
    background-color: #555; /* Darker background color on hover */
}

form a {
    color: #007bff; /* Blue color for the cancel link */
    text-decoration: none; /* Remove underline */
    font-size: 16px; /* Font size */
}

form a:hover {
    text-decoration: underline; /* Underline on hover */
}
    
/* Page header styling */
.page-header {
    background-color: #ffffff; /* White background for the header */
    padding: 20px; /* Padding inside the header */
    border-bottom: 1px solid #ddd; /* Light border at the bottom */
    margin-bottom: 20px; /* Space below the header */
}

.page-header h1 {
    margin: 0; /* Remove default margin */
    font-size: 1.5rem; /* Larger font size for the title */
    color: #333; /* Dark gray color */
}

.page-header small {
    color: #888; /* Light gray color for the breadcrumb */
}
    
    </style>
</head>
<body>


  <%@ include file="adminheader.jsp" %>
 <div class="page-header">
                <h1>Edit Customer Details</h1>
                <small>Home / Edit Customer Details</small>
            </div>
    <div class="main-content">
        
            
        <main>
            <%
                Connection conn = null;
                PreparedStatement pstmt = null;
                ResultSet rs = null;
                int uid = Integer.parseInt(request.getParameter("uid"));

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/restaurant", "root", "1234");
                    String sql = "SELECT uid, name, email, password FROM register WHERE uid = ?";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, uid);
                    rs = pstmt.executeQuery();

                    if (rs.next()) {
            %>
            <form action="http://localhost:8090/restaurant/NewCustomerEditServlet" method="post">
                <input type="hidden" name="uid" value="<%= rs.getInt("uid") %>">
                <label for="name">Name:</label>
                <input type="text" id="name" name="name" value="<%= rs.getString("name") %>" required>
                <br>
                <label for="email">Email:</label>
                <input type="email" id="email" name="email" value="<%= rs.getString("email") %>" required>
                <br>
                <label for="password">Password:</label>
                <input type="password" id="password" name="password" value="<%= rs.getString("password") %>" required>
                <br>
                <button type="submit">Update</button>
                <a href="http://localhost:8090/restaurant/admin/jsp/manage-customers.jsp">Cancel</a>
            </form>
            <%
                    } else {
                        out.println("Customer not found.");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            %>
        </main>
    </div>
</body>
</html>
