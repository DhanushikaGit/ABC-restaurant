<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Reservations</title>
    <style>
        .btn { padding: 5px 10px; border: none; cursor: pointer; }
        .btn-success { background-color: #28a745; color: #fff; }
        .btn-danger { background-color: #dc3545; color: #fff; }
        .btn-warning { background-color: #ffc107; color: #000; }
        .btn-primary { background-color: #007bff; color: #fff; }
    </style>
</head>
<body>

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
                <input type="submit" value="Confirm" class="btn btn-success">
            </form>
            <form action="http://localhost:8090/restaurant/CancelReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Cancel" class="btn btn-danger">
            </form>
            <form action="http://localhost:8090/restaurant/EditReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Edit" class="btn btn-primary">
            </form>
            <form action="http://localhost:8090/restaurant/PendingReservationServlet" method="post" style="display:inline;">
                <input type="hidden" name="reservation_id" value="<%= rs.getInt("id") %>">
                <input type="submit" value="Pending" class="btn btn-warning">
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
</html>
