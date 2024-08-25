<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet" href="css/style.css"> <!-- Link to your CSS file if needed -->
    <script>
        function validateForm() {
            var password = document.getElementById("password").value;
            var confirmPassword = document.getElementById("confirmPassword").value;
            if (password !== confirmPassword) {
                alert("Passwords do not match!");
                return false;
            }
            return true;
        }
    </script>
</head>
<body>

<h1>Register Here</h1>

<!-- Display error message if it exists -->
<% if (request.getAttribute("errorMessage") != null) { %>
    <div style="color: red;">
        <%= request.getAttribute("errorMessage") %>
    </div>
<% } %>

<form method="post" action="<%= request.getContextPath() %>/Register" onsubmit="return validateForm()">
    <label for="username">Name:</label><br>
    <input type="text" id="username" name="username" required><br><br>

    <label for="email">Email:</label><br>
    <input type="email" id="email" name="email" required><br><br>

    <label for="password">Password:</label><br>
    <input type="password" id="password" name="password" required><br><br>

    <label for="confirmPassword">Confirm Password:</label><br>
    <input type="password" id="confirmPassword" name="confirmPassword" required><br><br>

    <input type="submit" value="Register">
</form>

</body>
</html>
