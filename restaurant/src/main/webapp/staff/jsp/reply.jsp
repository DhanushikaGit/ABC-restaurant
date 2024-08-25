<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reply to Message</title>
    <style>
        .btn { padding: 5px 10px; border: none; cursor: pointer; }
        .btn-primary { background-color: #007bff; color: #fff; }
    </style>
</head>
<body>

<h2>Reply to Message</h2>

<form action="http://localhost:8090/restaurant/ReplyMessageServlet" method="post">
    <input type="hidden" name="message_id" value="<%= request.getParameter("message_id") %>">
    <div>
        <label for="reply">Reply:</label><br>
        <textarea id="reply" name="reply" rows="10" cols="50"></textarea>
    </div>
    <div>
        <input type="submit" value="Send Reply" class="btn btn-primary">
    </div>
</form>

</body>
</html>
