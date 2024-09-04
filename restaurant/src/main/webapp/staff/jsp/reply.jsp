<%@ page import="java.sql.*, com.JavaWebApplication.Model.mydb" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reply to Message</title>
    <style>
       /* Base styling */
body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 0;
    background-color: var(--light);
    color: var(--dark);
}

h2 {
    color: var(--primary);
    text-align: center;
    margin-top: 20px;
}

/* Form styling */
form {
    max-width: 600px;
    margin: 30px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

label {
    font-weight: bold;
    margin-bottom: 10px;
    display: block;
}

textarea {
    width: 100%;
    padding: 10px;
    margin-top: 5px;
    margin-bottom: 20px;
    border: 1px solid #ccc;
    border-radius: 4px;
    resize: vertical;
}

/* Button styling */
.btn {
    padding: 10px 20px;
    border: none;
    cursor: pointer;
    border-radius: 4px;
    font-size: 16px;
    font-weight: bold;
}

.btn-primary {
    background-color:  red;
    color:black;
   
}

.btn-primary:hover {
    background-color:  #F1F8FF;
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
<%@ include file="staffheader.jsp" %>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                    data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                    aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

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
<footer class="footer">
    <p>© 2024 ABC Restaurant. All rights reserved.</p>
</footer>
</body>
</html>
