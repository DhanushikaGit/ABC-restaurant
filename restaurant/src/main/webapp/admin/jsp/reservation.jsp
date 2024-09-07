<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title> ABC Restaurant Reservations</title>
     <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <style>
        /* Style for the page header */
.page-header {
    margin-bottom: 30px; /* Space below the header */
    padding: 20px; /* Padding inside the header */
    background-color: #f0f0f0; /* Light gray background for the header */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
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
/* Style for the search form */
form {
    max-width: 800px; /* Maximum width for the form */
    margin: 20px auto; /* Center the form horizontally */
    padding: 20px; /* Padding inside the form */
    background-color: #ffffff; /* White background for the form */
    border-radius: 8px; /* Rounded corners */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
}

/* Style for form labels */
form label {
    display: block; /* Block display for labels */
    margin-bottom: 8px; /* Space below each label */
    font-weight: bold; /* Make the labels bold */
    color: #333; /* Dark text color */
}

/* Style for form inputs */
form input[type="text"],
form input[type="date"],
form input[type="submit"] {
    width: calc(100% - 22px); /* Full width minus padding and border */
    padding: 10px; /* Padding inside the inputs */
    margin-bottom: 15px; /* Space below each input */
    border: 1px solid #ddd; /* Light border */
    border-radius: 4px; /* Rounded corners */
    box-sizing: border-box; /* Include padding and border in the element's total width and height */
    font-size: 16px; /* Font size */
}

/* Style for the submit button */
input[type="submit"] {
    background-color: red; /* Blue background */
    color: #fff; /* White text color */
    border: none; /* Remove default border */
    padding: 12px 20px; /* Padding inside the button */
    font-size: 16px; /* Font size */
    border-radius: 4px; /* Rounded corners */
    cursor: pointer; /* Pointer cursor on hover */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
}

input[type="submit"]:hover {
    background-color:  #FEA116; /* Darker blue on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Style for the table */
table {
    width: 100%; /* Full width of the container */
    border-collapse: collapse; /* Collapse table borders */
    margin: 20px 0; /* Space above and below table */
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
    border-radius: 8px; /* Rounded corners */
    overflow: hidden; /* Ensure no overflow */
}

/* Style for table headers */
table th {
    padding: 12px; /* Padding inside header cells */
    background-color: ; /* Green background for header */
    color: Black; /* White text color */
    text-align: left; /* Align text to the left */
    border-bottom: 2px solid #ddd; /* Light border at the bottom */
    font-weight: bold; /* Bold text */
}

/* Style for table cells */
table td {
    padding: 12px; /* Padding inside cells */
    border-bottom: 1px solid #ddd; /* Light border at the bottom */
    text-align: left; /* Align text to the left */
}

/* Hover effect for table rows */
table tr:hover {
    background-color: #f1f1f1; /* Light gray background on hover */
}

/* Style for action buttons in table */
table .btn {
    padding: 5px 10px; /* Padding inside buttons */
    border: none; /* Remove default border */
    border-radius: 4px; /* Rounded corners */
    color: #ffffff; /* White text color */
    cursor: pointer; /* Pointer cursor on hover */
    font-size: 14px; /* Font size */
    transition: background-color 0.3s ease, transform 0.2s ease; /* Smooth transition */
}

/* Success button styling */
.btn-success {
    background-color: #28a745; /* Green background */
}

.btn-success:hover {
    background-color: #218838; /* Darker green on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Danger button styling */
.btn-danger {
    background-color: #dc3545; /* Red background */
}

.btn-danger:hover {
    background-color: #c82333; /* Darker red on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Warning button styling */
.btn-warning {
    background-color: #ffc107; /* Yellow background */
    color: #000; /* Black text color */
}

.btn-warning:hover {
    background-color: #e0a800; /* Darker yellow on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}

/* Primary button styling */
.btn-primary {
    background-color: black; /* Blue background */
}

.btn-primary:hover {
    background-color: red; /* Darker blue on hover */
    transform: scale(1.05); /* Slightly enlarge button on hover */
}
        
    </style>
</head>
<body>
  <%@ include file="adminheader.jsp" %>
<div class="page-header">
                <h1>Our Reservation</h1>
                <small>Home / Reservation Details Details</small>
            </div>

<!-- Search Form -->
<form action="http://localhost:8090/restaurant/admin/jsp/reservation.jsp" method="get">
    <label for="searchName">Name:</label>
    <input type="text" id="searchName" name="name" value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>">
    
    <label for="searchEmail">Email:</label>
    <input type="text" id="searchEmail" name="email" value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>">
    
    <label for="searchDate">Reservation Date:</label>
    <input type="date" id="searchDate" name="reservation_date" value="<%= request.getParameter("reservation_date") != null ? request.getParameter("reservation_date") : "" %>">
    
    <input type="submit" value="Search" class="btn btn-primary">
</form>

<table border="1">
    <tr>
        <th>Name</th>
        <th>Email</th>
        <th>Contact</th>
        <th>Reservation Date</th>
        <th>Reservation Time</th>
        <th>People</th>
        <th>Session</th>
        <th>Location</th>
        <th>Message</th>
        <th>Status</th>
      
    </tr>

    <%
        mydb db = new mydb();
        Connection conn = db.getCon();
        if (conn != null) {
            // Prepare SQL query based on search parameters
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String reservationDate = request.getParameter("reservation_date");
            
            StringBuilder sql = new StringBuilder("SELECT * FROM reservations WHERE 1=1");
            if (name != null && !name.trim().isEmpty()) {
                sql.append(" AND name LIKE ?");
            }
            if (email != null && !email.trim().isEmpty()) {
                sql.append(" AND email LIKE ?");
            }
            if (reservationDate != null && !reservationDate.trim().isEmpty()) {
                sql.append(" AND reservation_date = ?");
            }
            
            try (PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {
                int index = 1;
                if (name != null && !name.trim().isEmpty()) {
                    pstmt.setString(index++, "%" + name + "%");
                }
                if (email != null && !email.trim().isEmpty()) {
                    pstmt.setString(index++, "%" + email + "%");
                }
                if (reservationDate != null && !reservationDate.trim().isEmpty()) {
                    pstmt.setString(index++, reservationDate);
                }
                
                try (ResultSet rs = pstmt.executeQuery()) {
                    while (rs.next()) {
    %>
    <tr>
        <td><%= rs.getString("name") %></td>
        <td><%= rs.getString("email") %></td>
        <td><%= rs.getString("contact") %></td>
        <td><%= rs.getString("reservation_date") %></td>
        <td><%= rs.getString("reservation_time") %></td>
        <td><%= rs.getString("people") %></td>
        <td><%= rs.getString("session") %></td>
        <td><%= rs.getString("location") %></td>
        <td><%= rs.getString("message") %></td>
        <td><%= rs.getString("status") %></td> <!-- Displaying the status -->
        
    </tr>
    <%
                    }
                }
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
    %>
</table>

</body>
  <%@ include file="adminfooter.jsp" %>
</html>
