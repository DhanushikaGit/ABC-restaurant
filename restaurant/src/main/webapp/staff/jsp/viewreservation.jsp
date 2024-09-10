<%@ page import="java.sql.*,com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Reservations</title>
      <link href="/restaurant/customer/images/A B C (1).png" rel="icon">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
               :root {
            --primary: #FEA116;
            --light: #F1F8FF;
            --dark: #0F172B;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: var(--light);
            color: var(--dark);
        }

        h2 {
            color: var(--primary);
        }

        form {
            margin-bottom: 20px;
        }

        input[type="text"], input[type="date"] {
            padding: 5px;
            margin: 5px;
            border: 1px solid var(--dark);
            border-radius: 3px;
        }

        .btn {
            padding: 5px 10px;
            border: none;
            cursor: pointer;
            font-size: 16px;
            border-radius: 3px;
        }

        .btn-success {
            background-color: #28a745;
            color: #fff;
        }

        .btn-danger {
            background-color: #dc3545;
            color: #fff;
        }

        .btn-warning {
            background-color: #ffc107;
            color: #000;
        }

        .btn-primary {
            background-color: var(--primary);
            color: #fff;
        }

        .btn-success:hover, .btn-danger:hover, .btn-warning:hover, .btn-primary:hover {
            opacity: 0.8;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            padding: 10px;
            text-align: left;
            border: 1px solid var(--dark);
        }

        th {
            background-color: var(--primary);
            color:black;
        }

        tr:nth-child(even) {
            background-color: var(--light);
        }

        tr:nth-child(odd) {
            background-color: #ffffff;
        }

        .icon {
            font-size: 16px;
        }
      
    </style>
</head>
<body>
  <%@ include file="staffheader.jsp" %>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
  

<h2>Reservations</h2>

<!-- Search Form -->
<form action="viewreservation.jsp" method="get">
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
        <th>Action</th>
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
        <td>
            <form action="http://localhost:8090/restaurant/ConfirmReservationServletstaff" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <button type="submit" class="btn btn-success"><i class="fas fa-check icon"></i></button>
            </form>
            <form action="http://localhost:8090/restaurant/CancelReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <button type="submit" class="btn btn-danger"><i class="fas fa-times icon"></i></button>
            </form>
            <form action="http://localhost:8090/restaurant/EditReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <button type="submit" class="btn btn-primary"><i class="fas fa-edit icon"></i></button>
            </form>
            <form action="http://localhost:8090/restaurant/PendingReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <button type="submit" class="btn btn-warning"><i class="fas fa-hourglass-half icon"></i></button>
            </form>
        </td>
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
  <%@ include file="staffooter.jsp" %>
</html>
