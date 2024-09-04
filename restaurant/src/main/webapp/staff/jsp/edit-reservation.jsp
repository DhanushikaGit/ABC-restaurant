<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>

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
    <meta charset="UTF-8">
    <title>Edit Reservation</title>
</head>
<body>
<%@ include file="staffheader.jsp" %>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

<h2>Edit Reservation</h2>

<form action="http://localhost:8090/restaurant/UpdateReservationServlet" method="post">
    <input type="hidden" name="reservation_id" value="<%= request.getAttribute("reservation_id") %>">
    
    <label for="name">Name:</label>
    <input type="text" id="name" name="name" value="<%= request.getAttribute("name") %>" required>
    <br>
    
    <label for="email">Email:</label>
    <input type="email" id="email" name="email" value="<%= request.getAttribute("email") %>" required>
    <br>
    
    <label for="contact">Contact:</label>
    <input type="text" id="contact" name="contact" value="<%= request.getAttribute("contact") %>" required>
    <br>
    
    <label for="reservation_date">Reservation Date:</label>
    <input type="date" id="reservation_date" name="reservation_date" value="<%= request.getAttribute("reservation_date") %>" required>
    <br>
    
    <label for="reservation_time">Reservation Time:</label>
    <input type="time" id="reservation_time" name="reservation_time" value="<%= request.getAttribute("reservation_time") %>" required>
    <br>
    
    <label for="people">People:</label>
    <input type="number" id="people" name="people" value="<%= request.getAttribute("people") %>" required>
    <br>
    
    <label for="session">Session:</label>
    <input type="text" id="session" name="session" value="<%= request.getAttribute("session") %>" required>
    <br>
    
    <label for="location">Location:</label>
    <input type="text" id="location" name="location" value="<%= request.getAttribute("location") %>" required>
    <br>
    
    <label for="message">Message:</label>
    <textarea id="message" name="message" required><%= request.getAttribute("message") %></textarea>
    <br>
    
    <button type="submit">Update</button>
    <a href="/restaurant/staff/jsp/viewreservation.jsp">Cancel</a>
</form>
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</body>
</html>
